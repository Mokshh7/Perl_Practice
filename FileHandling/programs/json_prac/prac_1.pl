use strict;
use warnings;
use feature 'say';
use JSON;

my %hash = (
a => 1,
b => 2,
c => 3,
);


my $json = to_json(\%hash);
say $json;

