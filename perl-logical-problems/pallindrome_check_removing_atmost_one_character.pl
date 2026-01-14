use strict;
use warnings;
use feature 'say';


sub palchk{

my ($input) = @_; 
my $count = 0;
for (my $i = 0 ; $i < length($input)/2 ; $i++){
my $lenn = length($input);
my $len = $lenn - $i -1 ;

if (substr($input,$i,1) ne substr($input,$len,1)){
#say substr($input,$i,1) . substr($input,$len,1);
#say "pal condition ";
$count++;
}}
if ($count == 0){say "$input is a : pallindrome";}
else {say "$input is not a : pallindrome";}
}


my $input = "abbca";

for (my $i = 1 ; $i < length($input) ; $i++){

my $inputt = $input;
substr($inputt , $i, 1) = '';
palchk($inputt);

}
