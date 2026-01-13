use strict;
use warnings;
use feature 'say';

my @arr = (10,20,30,10,40,30,50,10);
my $flag = 0;
for (my $j = 0 ; $j < @arr ; $j++){
my $flag = 0;


for(my $k = 0 ; $k < $j ; $k++){
if($arr[$k] == $arr[$j]){$flag = 1;last;}
}

next if $flag;

for (my $i = $j+1 ; $i < @arr ; $i++){
#my $flag = 0;
if ($arr[$j] == $arr[$i]){

say "$arr[$j]";
last;
}

}}
