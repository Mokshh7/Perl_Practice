use strict;
use warnings;
use feature 'say';

my @customerlist = ("alex","",undef,"john","riya" );

my @newlist = grep{$_ ne undef && $_ ne ''}@customerlist;

say join(",",@newlist);
