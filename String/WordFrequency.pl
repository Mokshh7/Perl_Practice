 use feature 'say';
use warnings;
use strict;

my $n = 2;
my $input = "great service great product";
my @arr = split /\s+/, lc $input; 

my %freq;

foreach (@arr){$freq{$_}++ ;}

my @words = sort{$freq{$b} <=> $freq{$a}} keys %freq;

my @topn = @words[0..$n];
my @norm = join(",",@topn);
say @norm




