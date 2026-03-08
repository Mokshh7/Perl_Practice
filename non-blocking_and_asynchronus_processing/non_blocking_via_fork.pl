use strict;
use warnings;
use feature 'say';

my $pid = fork();

if (!defined $pid) {
    die "Cannot fork: $!";
}



if($pid == 0 ){
sleep 5;
say "child finished work";
}else{
say "parent finished work";
}
