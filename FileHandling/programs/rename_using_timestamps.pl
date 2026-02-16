use strict;
use warnings;
use feature 'say';

my $timestamp = time;

for my $file(glob "*.log"){
my $new = "${timestamp}_$file";
rename $file,$new or warn $!;
}
