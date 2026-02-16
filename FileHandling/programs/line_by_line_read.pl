use strict;
use feature 'say';
use warnings;
use Text::CSV;

my $file = '../data/input.txt';

open(my $fh,"<",$file)
or die "$!";

while (my $line = readline($fh)){

chomp $line;
say "read : $line";
}

close $fh;
