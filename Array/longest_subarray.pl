use strict;
use warnings;
use feature 'say';

my @array = (10,20,30,40,50);

my $k = 90;

foreach(@array){
my @arr;
for(my $i = 0 ; $i < @array ; $i++){
for(my $j = 0 ; $j < @array ; $j++){
if($_ + $array[$i] == $k || ){
push (@arr,$_,$array[$i]);
}

}

}

}
