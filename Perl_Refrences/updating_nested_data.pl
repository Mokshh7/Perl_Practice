use strict;
use warnings;
use feature 'say';


my $hashref = [{ name=>"Alice", salary=>60000,},
{name=> "Moksh" , salary=>6000000}];

foreach my $keys (@$hashref){

my $bonus = $keys->{salary} * 0.10;
$keys->{bonus} = $bonus;
}


use Data::Dumper;

print Dumper($hashref);
