use strict;
use warnings;
use feature 'say';

my @commands = qw(whoami date uptime);

foreach (@commands){
say "$_ exicuting...";
my $output = `$_ 2>&1`;
if($? == 0){
chomp $output;
say "$output";
}else{
say "$_";
}

say "";
}
say "common runner tool completed successfully";
