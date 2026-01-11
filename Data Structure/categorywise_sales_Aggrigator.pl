use strict;
use warnings;
use feature 'say';

my $string = [
  ["Electronics", 1000],
  ["Furniture",   2000],
  ["Electronics", 1500]
];

my $hash = {};
for (my $i = 0 ; $i < @{$string} ; $i++){
if (exists $hash->{$string->[$i]->[0]})
{
$hash->{$string->[$i]->[0]} += $string->[$i]->[1];

}else{$hash->{$string->[$i]->[0]} = $string->[$i]->[1]}
}

foreach (keys %{$hash}){

say "$_ => $hash->{$_}";

}
