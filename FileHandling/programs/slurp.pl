use strict;
use warnings;
use feature 'say';

open(my $fh , "<" , "../data/input.txt")
or die "$!";

my $content ;
 read($fh,$content,10,0);
local $/;
my $contentt = readline($fh);
close $fh;

say $contentt;
