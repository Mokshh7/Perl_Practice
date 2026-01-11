use strict;
use warnings;
use feature 'say';

my $hash1 = { timeout => 10 };

my $hash2 = { timeout => 20, debug => 1 };

foreach my $ref1(keys %{$hash1}){
foreach my $ref2(keys %{$hash2}){
if ($ref1 eq $ref2){
$hash1->{$ref1} += $hash2->{$ref2};
}


}}

foreach my $keys (keys %{$hash2}){

say "$keys => $hash2->{$keys}";

}
