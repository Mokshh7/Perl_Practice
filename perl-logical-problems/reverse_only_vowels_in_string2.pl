use strict;
use warnings;
use feature 'say';


my $input = "hello world";

my @array = split / / , $input;
#@arr;
foreach (@array){

my @arr;
my @keys = split //,$_;

for(my $i = 0 ; $i < @keys ; $i++){

if( $keys[$i] =~ /[aeiou]/i){
push(@arr,$keys[$i]);


}say @arr;
}

#@arr = reverse @arr; 
for(my $j = 0 ; $j < @keys ; $j++){
if($keys[$j] =~ /[aeiou]/i){
$keys[$j] = pop @arr;
}


}
my $new_word = join "",@keys;
say $new_word;
}
