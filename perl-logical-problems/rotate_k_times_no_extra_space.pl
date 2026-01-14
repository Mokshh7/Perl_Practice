use strict;
use warnings;
use feature 'say';


my @input = (1,2,3,4,5,6,7);

my $k = 2;

for(my $i = 0 ; $i < $k ; $i++){

for (my $j = @input - 1 ; $j > 0 ; $j--){


$input[$j] = $input[$j] + $input[$j - 1];
$input[$j - 1] = $input[$j] - $input[$j -1];
$input[$j] = $input[$j] - $input[$j-1];

}}
say @input;

