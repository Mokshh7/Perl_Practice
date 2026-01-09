use strict;
use warnings;
use feature 'say';
my $input = <<EOF;
ERROR: Disk full
WARNING: Low memory
INFO: Started
ERROR: Network down

EOF

my @matches = $input =~ m/^ERROR.*$/mg;

say @matches;

