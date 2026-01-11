use strict;
use warnings;
use feature 'say';

my $devices = ["Laptop", "Phone", "Tablet"];
my $prices = [70000, 30000, 25000];

my %hash;


foreach (@{$devices}){
for(my $i = 0; $i<@{$prices} ; $i++){
$hash{$_} = $prices->[$i];


}
}
foreach my $key (keys %hash){
say "$key => $hash{$key}";
}
