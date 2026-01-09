use strict;
use warnings;
use feature 'say';
my $text = "Item 42";

$text =~ /(\w+)\s+(\d+)/;

#say $1;  
#say $2;  


#my $text = "Perl is fast";

while ($text =~ /\w+ /g) {
   # say $text;
}


my $count=0;
my $input = "perl is?perl is?! perl is....crazzzyyyyyyyyy!";

my $copy = lc $input;
my $unique = () = $copy =~ s/\b(\w+)\b(?!.*\b\1\b)//g;
say $unique;
