use strict;
use warnings;
use feature 'say';

my @array = ("Alex", "", undef, "John", "Riya");


grep{@_ ne ""}@array;

say join(" ",@array);
