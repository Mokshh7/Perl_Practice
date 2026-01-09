use strict;
use warnings;
use feature 'say';

my @array = qw(a b c d e);
my $lenn = @array;

my $k = 2;
if ($k >= $lenn){
        $k = $k - $lenn;
 }
say "value of k : $k";

my $temp;
for (my $i=0; $i < $k ; $i++){
say "inside for loop";
$temp = $array[$lenn-1];
for (my $j = $lenn-1 ; $j > 0 ; $j--){

$array[$j] = $array[$j-1];

}
$array[0] = $temp;
}

say join (",",@array) ;



