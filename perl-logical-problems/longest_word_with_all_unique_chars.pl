use strict;
use warnings;
use feature 'say';


my $input = "abc abcd aabcde";

my @array = split / /,$input;



foreach (@array){
my $count = 0;
for (my $i = 0 ; $i < length($_) ; $i++){
#my $count = 0;
for (my $j = $i + 1 ; $j < length($_) ; $j++){
#if($i == $j){next;}
if (substr($_,$i,1) eq substr($_,$j,1)){
$count = 1;
last;
}
}
last if $count;
}

if (!$count){ 
say "unique : $_"; last;
}else {say "not unique";}

}
