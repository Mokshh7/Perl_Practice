use strict;
use feature 'say';
use warnings;

my $html = "<div><span>Text</span></div>";
my @ext = $html =~ /^<div>(.*?)<\/div>$/g;
say $1;
