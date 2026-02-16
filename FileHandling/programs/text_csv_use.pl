use strict;
use warnings;
use feature 'say';

use Text::CSV;


open (my $fh , "<" , "../data/raw_input.csv")
or die "$!";


my $csv = Text::CSV->new({
    binary     => 1,
    auto_diag => 1,
});
my $header = $csv->getline($fh);
$csv->column_names(@$header);
while(my $row = $csv->getline_hr($fh)){

say "$row->{age}";

}
