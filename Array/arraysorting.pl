use strict;
use warnings;
use feature 'say';

my @array = (1,2,9,4,7,6,9);

foreach my $i (@array){
foreach my $j(@array){
if ($i > $j){
my $temp = $i;
$i = $j;
$j = $temp;
}
}
}

foreach my $n(@array){
say $n;
}
say (@array)
