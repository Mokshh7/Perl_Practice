use strict;
use warnings;
use feature 'say';

my $text = "Price: 100\nTax: 18\n";

$text =~ s/(\d+(?:\.\d+))//;
