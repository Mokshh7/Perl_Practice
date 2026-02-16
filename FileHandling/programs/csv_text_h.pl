use strict;
use warnings;
use feature 'say';
use Text::CSV;

open(my $fh,  '<', '../data/input.csv')  or die $!;
open(my $out, '>>', '../output/output.csv') or die $!;

open(my $bad, '>>', '../output/bad.csv')   or die $!;

my $csv = Text::CSV->new({
    binary     => 1,
    auto_diag => 1,
    allow_loose_quotes => 1,
    allow_unquoted_escape  => 1,
});

my $header = $csv->getline($fh);

$csv->column_names(@$header);
$csv->say($out,$header);


while(1){
my $row = $csv->getline_hr($fh);
if($row){
$csv->say($out,[$row->{id}]);
say $out;
next;
}


my ($code,$msg) = $csv->error_diag;
say $msg;
last if $code == 2012;

say $bad $csv->error_input;

}

close($fh);
