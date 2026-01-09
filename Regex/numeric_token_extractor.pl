use strict;
use warnings;
use feature 'say';

my $input = "abc123def456gh";

my @arr = $input =~ /(\d+)/cg;

say join (",",@arr);
