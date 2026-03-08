use strict;
use warnings;
use feature 'say';
use Text::CSV;
use MongoDB;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db = $client->get_database("companyDB");
my $collection = $db->get_collection("employees");

my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

open(my $fh, "<", "employees.csv") or die "Cannot open CSV file: $!";

my $header = $csv->getline($fh);
open(my $fh , "<" , "data/data_csv") or die;

my $headline = $csv->getline($fh);

while (my $row = $csv->getline($fh)){
my %doc ;
@doc{@$header} = @$row;


}
