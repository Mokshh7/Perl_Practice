use strict;
use warnings;
use feature 'say';


my @input = (4,3,1,3,4,2);
my %hash;
for(my $j = 0 ; $j < @input ; $j++){

for(my $i = 0 ; $i < @input ; $i++){
#$count = $input[$j];
if($i == $j){last;}
if($input[$j] eq $input[$i]){
$hash{$input[$j]} = $j;
 
}
}
}


my ($max_key) = sort { $hash{$b} <=> $hash{$a} } keys %hash;

say $hash{$max_key};
