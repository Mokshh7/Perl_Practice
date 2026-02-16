use strict;
use feature 'say';
use warnings;

system("ls","-l");
system("cowsay","mooooo");

my $date = `date`;
chomp $date;
say "current date: $date";




