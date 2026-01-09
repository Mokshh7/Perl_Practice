use strict;
use warnings;
use feature 'say';


my $input = "iusdjc akjncin idjc, bcs. uisvn";

my $words = () = $input =~ /(\b\w+\b)+/g;
my $lines = () = $input = /\n/g;


#my @word = () = $input =~ /(\b\w+\b)+/g;

my $copy;
my %unique = () = $copy =~ s/\b\(w+)\b(?!.*\b\1\b)//g;




say $words;
say $lines;
