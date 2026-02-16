use strict;
use warnings;
use feature 'say';
use Fcntl qw(:flock);

open(my $log , ">>" , "../data/app.log")
or die "$!";

flock($log,LOCK_EX)
or die "lock failed";

say $log scalar(localtime), "- safe log entry";

flock($log,LOCK_UN);
close $log;
