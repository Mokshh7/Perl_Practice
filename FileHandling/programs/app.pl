use strict;
use warnings;
use feature 'say';
use File::Spec;
use File::Basename;

my $log_dir = shift or die "Usage: perl log_pipeline.pl <logs_directory>\n";
-d $log_dir or die "Not a directory: $log_dir\n";


my $errors_log   = "../output/errors.log";
my $warnings_log = "../output/warnings.log";
my $invalid_log  = "../output/invalid.log";
my $summary_csv  = "../output/summary.csv";


open my $err_fh,   ">>", $errors_log   or die $!;
open my $warn_fh,  ">>", $warnings_log or die $!;
open my $bad_fh,   ">>", $invalid_log  or die $!;


open my $csv_fh, ">", $summary_csv or die $!;
say $csv_fh "date,service,error_count,warn_count,info_count";

my $LOG_RE = qr{
    ^\[
        (\d{4}-\d{2}-\d{2})      # date
        \s+
        \d{2}:\d{2}:\d{2}
    \]
    \s+
    (ERROR|WARN|INFO)            # level
    \s+
    (\S+)                        # service
    \s+
    (.+)                         # message
$
}x;

my %seen;
my %stats;

for my $file($errors_log,$warnings_log){

next unless -e $file;
open (my $fh , "<" , $file) or next;

while(readline($fh)){

chomp;
$seen{$_} = 1;
}
close $fh;
}

for my $log_file(glob File::Spec->catfile($log_dir,"*.log")){

open my $fhh, "<" , $log_file or do{
say $bad_fh "can't open file : $log_file";
next;
};

while(my $line = readline($fhh)){
chomp $line;

if ($line =~ $LOG_RE){
my ($date , $level , $service , $stat) = ($1,$2,$3,$4);

$stats{$date}{$service}{ERROR}++;
$stats{$date}{$service}{WARN}++;
$stats{$date}{$service}{INFO}++; 
$stats{$date}{$service}{$level}++;

unless($seen{$line}){
if ($level eq "ERROR"){
say $err_fh $line;
}

                elsif ($level eq 'WARN') {
                    say $warn_fh $line;
                }
                $seen{$line} = 1;
            }

        } else {
            say $bad_fh $line;
        }
    }

    close $fhh;
}

for my $date(sort keys %stats){

for my $service(sort keys %{ $stats{$date}}){

 
my $err = $stats{$date}{$service}{ERROR} // 0;
my $warn = $stats{$date}{$service}{WARN} // 0;
my $info = $stats{$date}{$service}{INF0} // 0;

say $csv_fh join ",",
$date,
$service,
$err,
$warn,
$info;

}
}

close $_ for ($err_fh, $warn_fh , $bad_fh , $csv_fh);

say "log pipeline completed sucessfully. ";
