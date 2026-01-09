use strict;
use warnings;
use feature 'say';
my %hash;
my $input = "Name: John Doe, Age: 29, City: Delhi";

my @array ; if ($input =~ /Name:(.*?), Age:(.*?), City:(.*)$/)
{$hash{name} = $1; $hash{age}=$2; $hash{City} = $3;}
say @array;
say %hash;
