use strict;
use warnings;
use feature 'say'; 

my @array = (" madam","hello","civic"); 
sub aaa{

my (@array) = @_ ;

my $count;
for(my $j = 0 ; $j< @array ; $j++){
my $input = $array[$j];
$input =~ s/ //g; 

my @iinput = split //,$input;
my $len= @iinput-1;
my $lenn = @iinput/2;
for (my $i = 0 ; $i < $lenn ; $i++){
$count = 0;
if ($iinput[$i] ne $iinput[$len-$i]){
$count++;
}

if ($count>0){say "$array[$j] is not a pallindrome"; last;}
else{say "$array[$j] is a pallindrome"; last;}
}}}
aaa(@array);
