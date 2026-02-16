use strict;
use warnings;
use feature 'say';

my $filename = shift @ARGV
or die "useage: $0 <filename>";

say "file: $filename";
