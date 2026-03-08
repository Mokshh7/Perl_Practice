package CDR::Processor;

use strict;
use warnings;
use feature 'say';

use Text::CSV;
use File::Copy qw(move);
use File::Basename qw(basename);
use POSIX qw(strftime);

use CDR::Parser;
use CDR::Validator;
use CDR::Billing::Calculator;

sub new{
my($class,%args) = @_;

die "DB handle required" unless $args{dbh};

my $self = {
dbh => $args{dbh},
parser => CDR::Parser->new(),
validator => CDR::Validator->new(),
calculator => CDR::Billing::Calculator->new(),
};

return bless $self , $class;
}

sub process_file{
my ($self , $file_path) = @_;

my $dbh = $self->{dbh};

my $filename = basename($file_path);

#counters 
my $total_records = 0;
my $rejected_count = 0;
my $total_revenue = 0;

#prepare sql statements
my $insert_processed = $dbh->prepare(q{
insert into processed_cdrs
(caller,callee,start_time,duration,call_type,charge,source_file)
values (?,?,?,?,?,?,?)
});

my $insert_invalid = $dbh->prepare(q{
insert into invalid_cdrs
(raw_record , reason , source_file)
values(?,?,?)
});


my $insert_summary = $dbh->prepare(q{
insert into mediation_summary 
(file_name , total_records , total_revenue , rejected_count)
values(?,?,?,?)
});


my $csv = Text::CSV->new({binary => 1})
or die "cannot create a csv parser : $!";

open my $fh , "<" , $file_path
or die "cannor open file $file_path : $!";

eval{
$dbh->begin_work;

my $is_header = 1;

while(my $row = $csv->getline($fh)){
#skip header 
if($is_header ){
$is_header = 0;
next;
}
$total_records++;

#reconstruct raw line for invalid logging 

my $raw_line = join ",",@{$row};

#parsing 

my $cdr = $self->{parser}->parse_row($row);

unless ($cdr){
$insert_invalid->execute(
$raw_line,
"Malformed CSV row",
$filename
);
$rejected_count++;
next;
}
my $validation = $self->{validator}->validate($cdr);

unless($validation->{valid}){
$insert_invalid->execute(
$raw_line,
$validation->{reason},
$filename
);
$rejected_count++;

next;
}


my $billing = $self->{calculator}->calculate($cdr);

my $charge = $billing->{charge};

$insert_processed->execute(
$cdr->{caller},
$cdr->{callee},
$cdr->{start_time},
$cdr->{duration},
$cdr->{call_type},
$charge,
$filename
);

$total_revenue += $charge;
}

close $fh ;

#insert summary

$insert_summary->execute(
$filename,
$total_records,
sprintf("%.2f",$total_revenue),
$rejected_count
);

$dbh->commit;


#creating a log :
my $dir = "/home/lab/CME/logs/"; 
opendir(my $lg , $dir) or die "cant open dir ";
while(my $fname = readdir($lg)){
if($fname eq "processed_sucessfully.log" ){
my $name = $dir . $fname;

open my $fhh , ">>" , $name or die;
my $str = strftime("%Y-%m-%d %H:%M:%S" , localtime());
say $fhh "[ $str ] SUCCESSFULLY PROCESSED FILE : $fname \n SUMMARY : FILE NAME - $filename , TOTAL RECORDS - $total_records , TOTAL REVENUE - $total_revenue , REJECTED COUNT - $rejected_count ";
close $fhh;
}
}
};

if ($@){
warn "processing failed : $@";
$dbh->rollback;
close $fh;
return 0;
}


#archive file after sucessfull commit 
my $archive_path = "/home/lab/CME/archived/$filename";

unless(move($file_path,$archive_path)){
warn "failed to archive file : $! ";
return 0;
}
return 1;
}
 
1;
