use strict;
use warnings;
use feature 'say';

my $input = <STDIN>;
my $counter = 0;
chomp($input);
my $i; 
for($i=2;$i<=$input/2;$i++){

if ($input % $i == 0){
$counter++;
}
}
if($counter == 1){
say "near prime";
}
else{
say "not near prime";
}

