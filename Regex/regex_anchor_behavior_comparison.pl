use strict;
use warnings;
use feature 'say';

my $text = "hello\nworld\nhello again";


my @text = $text =~ m/^hello/gm;
say @text;
my @textt;

while($text =~ m/\A.*?\b(hello)\b/s){
say $1;
$text =~ s/\A.*?\bhello\b//s;

}
