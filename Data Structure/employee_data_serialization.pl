use strict;
use warnings;
use feature 'say';

my @array = (["Alex","IT"],["Riya","HR"]);
my $arr = [];

foreach my $k (@array){

my %hash ;
$hash{name} = $k->[0];
$hash{dept} = $k->[1];
push (@{$arr},\%hash);


}
use Data::Dumper;
print Dumper($arr);
