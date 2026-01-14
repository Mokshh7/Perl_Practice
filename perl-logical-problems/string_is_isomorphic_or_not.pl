use strict;
use warnings;
use feature 'say';

my @input = (
    ["egg", "add"],
    ["foo", "bar"],
    ["boom", "attb"]
);
my %hash;

foreach my $pair(@input){

my ($s,$t) = @$pair;

if(length($s) != length($t)){


say "$s , $t => not isomorphic";
next;

}

my %s_to_t;
my %t_to_s;

my $iso = 1;

for(my $i = 0 ; $i < length($s); $i++){


my $c1 = substr($s,$i,1);
my $c2 = substr($t,$i,1);

if (exists $s_to_t{$c1}){
if ($s_to_t{$c1} ne $c2){

$iso = 0;
last;

}
}

if(exists $t_to_s{$c2}){

if($t_to_s{$c2} ne $c1){

$iso = 0;
last;
}

}

$s_to_t{$c1} = $c2;
$t_to_s{$c2} = $c1
}

if($iso){say "$s , $t => isomorphic";}
else{say "$s , $t => not isomorpic";}

}
