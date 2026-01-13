use strict;
use warnings;
use feature 'say';

my @array = (1,2,3,4,4,6,7);

 for (my $j = 0; $j < @array-1 ; $j++){

if(($array[$j + 1] - $array[$j]) != 1){
my $a = $array[$j] + 1;
say "missing number is $a";

}
my $flag = 0;

for (my $k = 0 ; $k < $j ; $k++){
if ($array[$k] == $array[$j]){ $flag = 1 }
}
next if $flag ==1;
for (my $i = $j + 1 ; $i < @array ; $i++){
if($array[$i] == $array[$j]){
say "repeted : $array[$j]";

}
}
}
