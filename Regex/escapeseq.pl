use strict ;
use warnings;
use feature 'say';


my $input = "Hello\\nWorld\\tPerl";
say $input;


$input =~ s/[\n]/\n/g;
$input =~ s/(\\n)/\n/g;
$input =~ s/(\\t)/\t/g;
say $input;
