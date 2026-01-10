use strict;
use warnings;
use feature 'say';

my $text = "Perl is fast... Isn't it great?! Yes!";

$text =~ s/\.{3,}//g;

my $count = 0;
$count += () = $text =~ /[.!?]+/g;

say "Sentence count: $count";
