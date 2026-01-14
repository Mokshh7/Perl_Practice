use strict;
use warnings;
use feature 'say';

my $word = "hello";

my %keypad = (
    2 => ["a", "b", "c"],
    3 => ["d", "e", "f"],
    4 => ["g", "h", "i"],
    5 => ["j", "k", "l"],
    6 => ["m", "n", "o"],
    7 => ["p", "q", "r", "s"],
    8 => ["t", "u", "v"],
    9 => ["w", "x", "y", "z"],
);





my %lookup;
for my $key (keys %keypad) {
  for my $i (0 .. $#{$keypad{$key}}) {
        $lookup{ $keypad{$key}[$i] } = [$key, $i + 1];
 }
}

my @letters = split //, $word;

for my $char (@letters) {
if (exists $lookup{$char}) {
my ($key, $presses) = @{ $lookup{$char} };
   say $key x $presses;
    }
}
