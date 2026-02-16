use strict;
use feature 'say';
use warnings;
use  File::Spec;
use Text::CSV;

my $csv = Text::CSV->new({
binary => 1,
});
my $csv_dir = shift or die $!;
-d $csv_dir or die ;
my @impt = ("employee_id","salary","status");
open(my $fhh , ">" , "../output/valid_records_report_automation.csv")
or die ;


open(my $fhhh , ">" , "../output/invalid_records_report_automation.csv")
or die ;

for my $csv_file(glob File::Spec->catfile($csv_dir,"*.csv")){

open(my $fh , "<" , $csv_file) or die;

my $header = $csv->getline($fh);
$csv->column_names(@$header);

while (my $row = $csv->getline_hr($fh)) {

    my @errors;

    push @errors, "missing employee_id"
        unless defined $row->{employee_id} && $row->{employee_id} =~ /\d+$/g ;

    push @errors, "missing salary"
        if !defined $row->{salary} || $row->{salary} eq '';

    push @errors, "missing status"
        if !defined $row->{status} || $row->{status} eq '';

    if (@errors) {
        $row->{reason} = join "; ", @errors;
        $csv->print($fhhh, [ @$row{ @$header }, $row->{reason} ]);
    } else {
        $csv->print($fhh, [ @$row{ @$header } ]);
    }
}
}
