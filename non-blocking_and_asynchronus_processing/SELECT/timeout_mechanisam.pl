use strict;
use warnings;
use feature 'say';
use Time::HiRes qw(time);

say "starting high-precision timer...";

my $start = time();

#no read/write vectors , only timeout
select(undef,undef,undef,2.5);

my $end = time();

say "Elapsed time: " . sprintf("%.3f", $end - $start) . " seconds";
