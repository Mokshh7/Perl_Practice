use strict;
use warnings;
use feature 'say';

my $word = "hello";


my %keypad = (
2 => ["a" ,"b","c"],
3 => ["d" , "e" , "f"],
4 =>["g", "h" , "i"],
5 =>["j","k","l"],
6 =>["m","n","o"],
7 =>["p","q","r","s"],
8 =>["t","u","v"],
9 =>["w","x","y","z"],
);


my @letters = split //,$word;
foreach my $var(@letters){


foreach my $keys (keys %keypad){
for(my $i =0;$i<@{$keypad{$keys} };$i++){
if( $var eq $keypad{$keys}->[$i]){say $keys x $i;}
}
}
}
