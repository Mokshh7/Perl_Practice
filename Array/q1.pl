use strict;
use warnings;
use feature 'say';

my @input = (10,9,4,3,6,12);

foreach my $k(@input){
my $count = 0;
for (my $i = 2 ; $i <= $k/2 ; $i++){

if ($k % $i == 0){

$count++;


}
}
if($count == 1){
say "nearly prime : $k";
}


}
