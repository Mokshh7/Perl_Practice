use strict;
use feature 'say';
use warnings;

my @input = (10,20,30,40,70,1,10);
my @large;
for(my $i = 0 ; $i < @input ; $i++){

push(@large,($input[$i] * $input[$i + 1])) ;



}

say join ",",sort @large;
