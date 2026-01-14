use strict;
use warnings;
use feature 'say';


my $input = "swiss";

for(my $i = 1 ; $i < length($input) ; $i++ ){
my $count = 0;
for(my $j = 1 ; $j < length($input) ; $j++ ){

if ($i eq $j){next;}
if (substr($input,$i,1) eq substr($input,$j,1)){$count++;}

}


if($count == 0){ say "first non repeating character : " . substr($input,$i,1); last;}
}
