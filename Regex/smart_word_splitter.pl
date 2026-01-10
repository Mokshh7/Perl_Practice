
use strict;
use warnings;
use feature 'say';

my $input = "don't state-of-the-art randomword";
my @text = $input =~ m/(\w+(['-]\w+)+)[^(\-\w+ )]/g;
say join ",",@text; 

