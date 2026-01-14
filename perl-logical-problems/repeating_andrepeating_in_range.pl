use strict;
use warnings;
use feature 'say';

my @input = (1,2,2,4,5);

for(my $i = 0 ; $i < @input - 1 ; $i++){
my $count = 0;
if($input[$i + 1 ] - $input[$i] > 1 ){say " missing : " . ($input[$i] + 1)
 ;
next;
}
for(my $j = 0 ; $j < @input ; $j++){

if ($i == $j){next;};
if($input[$i] == $input[$j]){$count++;}}
  if ($count == 1){say "repeated : " . $input[$i] ;}

}

say "yes";
