use strict;
use warnings;
 use feature 'say';


my $input = "aaaaa";

my @array = $input =~ m/\Ga/g;

say "@array";
