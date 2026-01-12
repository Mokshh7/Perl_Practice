use strict;
use feature 'say';
use warnings;

my $hashref = [
{ name=>"Alice", salary=>60000 },
{ name=>"Bob", salary=>40000 }
];

my @pr;
foreach my $keys (@$hashref){

if ($keys->{salary} > 50000){ say $keys->{name};}
}

