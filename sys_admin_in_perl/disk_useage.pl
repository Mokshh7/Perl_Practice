use strict;
use warnings;
use feature 'say';

my @output = `df -h`;
use Data::Dumper;
say Dumper(@output);
foreach(@output){
if($_ =~ /(\d+)%/){
say "useage $1%";
}
}

