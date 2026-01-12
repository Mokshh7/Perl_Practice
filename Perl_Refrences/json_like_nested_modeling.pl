use strict;
use warnings;
use feature 'say';

my %hash;

$hash{Tata_Communication}->{IT} = ["a","b","c"];

foreach(keys %hash){

say "@{$hash{$_}->{IT}}"

}

use Data::Dumper;

print Dumper(%hash);
