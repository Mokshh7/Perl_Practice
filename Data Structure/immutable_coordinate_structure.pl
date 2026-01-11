use strict ;
use warnings ;
use feature 'say';


my $array = [10,20,30];

for(my $i = 0 ; $i < @{$array} ; $i++){

if($i == 0){
say "x = $array->[$i]";
}elsif($i == 1){
say "y = $array->[$i]";
}else{say "z = $array->[$i]";}


}
