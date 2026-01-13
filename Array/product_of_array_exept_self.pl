use strict;
use warnings;
use feature 'say';

my @num = (1,2,3,4,5);

my @output;
for (my $i = 0; $i < @num; $i++){

my $prod = 1;
 for (my $j = 0; $j < @num; $j++){
 next if $i == $j;
$prod *= $num[$j] 

}
push @output,$prod;
}

say join ",",@output;
