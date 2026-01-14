use strict;
use feature 'say';
use warnings;


my @input = (1,2,3,2,4,5,1,1,6);

my %output;
foreach(@input){
my $count = 0;
for(my $i = 0 ; $i < @input ; $i++){

if ($_ == $input[$i]){

$count++;

}

}
if($count == 2){
$output{$_} = 0;

}
}
say keys %output;

