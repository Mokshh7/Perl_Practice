use strict;
use warnings;
use feature 'say';
 

my $hours = "12:34:56 98:76:54";

my @hour1 ;
@hour1 = $hours =~ /(\d+):\d+:\d+/g;
say @hour1;
