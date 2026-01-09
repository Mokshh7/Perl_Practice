 use strict;
use warnings;
use feature 'say';

my $input = "name :   john";

if ($input =~ m/(\w+) :   \w+/){say "yes";}
