use strict;
use warnings;
use feature 'say';

open STDERR, ">" , "errors.log"
or die "cannot redirect STDERR : $! ";
warn "this all goes to errors.log";
