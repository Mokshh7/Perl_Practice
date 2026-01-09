use strict;
use warnings;
use feature 'say';

my $input = "John,, Doe!!, New York ";


$input =~ s/[!@$%^&*]+//g;
$input =~ s/\s*,\s*,/, /g;
$input =~ s/  / /g;
say $input;

