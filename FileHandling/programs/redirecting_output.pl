use strict;
use warnings;
use feature 'say';

open my $out, ">","output.txt"
or die "$!";

say $out "hello file";

close $out;
