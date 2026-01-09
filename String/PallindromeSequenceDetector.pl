use strict;
use feature 'say';
use warnings;

my @input = qw(ABA12 1221 XYZ);

 foreach (@input){

if($_ eq reverse $_){
say "$_ is pallindrome";
}

}
