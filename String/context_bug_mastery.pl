use strict;
use warnings;
use feature 'say';
my $text = "this is a sample text";
my @words = split /\s+ /, $text;
my $count = @words;
print "Words: $count\n";
