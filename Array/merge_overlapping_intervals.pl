use strict;
use warnings;
use feature 'say';

my @input = ([1,3],[2,6],[8,10],[15,18]);

my @verynew;
for(my $j = 0 ; $j < @input ; $j++){
for (my $i = $j + 1 ; $i < @input ; $i++){
if($input[$j]->[1] > $input[$i]->[0]){ 
my @new ;
push (@new , $input[$j]->[0],$input[$i]->[1]);
push (@verynew,\@new);
last;
} push(@verynew,$input[$i]);last;
}
}

foreach(@verynew){say @{$_}}
