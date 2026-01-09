use strict;
use warnings;
use feature 'say';

my $input = "cat scatter bobcat catfish polecat cat";

while ($input =~ /(cat)/g){
my $match = $1;
my $pos = pos($input);
say $pos;
my $start = $pos - length;




}
