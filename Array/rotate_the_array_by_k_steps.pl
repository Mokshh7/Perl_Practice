use strict;
use feature 'say';
use warnings;

my @input = (10,20,30,40,70);
my $k = 2;
for(my $i = 0 ; $i < $k ; $i++){
for(my $j = @input - 1 ; $j > 0 ; $j--){
$input[$j] = $input[$j]+$input[$j-1];
$input[$j - 1] = $input[$j] - $input[$j-1];
$input[$j] = $input[$j] - $input[$j - 1];
}
}
say @input;

