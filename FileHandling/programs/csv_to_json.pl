use strict;
use warnings;
use feature 'say';

use JSON;
use Text::CSV;

my $csv_in = "../data/csv_to_json.csv";
my $json_out = "../output/csv_to_json.json";

my $csv = Text::CSV->new({
binary => 1,
auto_diag => 1,
allow_loose_quotes => 1,
});
my $json = JSON->new->pretty;

open(my $fh , "<", $csv_in)
or die $!;


open(my $fhh , ">>", $json_out)
or die $!;

my $header = $csv->getline($fh);
$csv->column_names(@$header);
my @rows;
while(my $row = $csv->getline_hr($fh)){
push @rows , $row;
}

say $fhh $json->encode(\@rows);

close $fh;
close $fhh;

