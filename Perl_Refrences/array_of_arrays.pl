use strict;
use feature 'say';
use warnings;

my $arrref = [
[1,2,3],
[4,5,6],
[7,8,9]
];
my $length = @$arrref;
for(my $i = 0 ; $i < $length ; $i++ ){

say "$arrref->[$i][$i]";


}
