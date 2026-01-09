use strict;
use warnings;
use feature 'say';


my @tests = (
    '"hello"',
    "'world'",
    '"broken\'',
    "'broken\"",
    '"valid again"',
    "'also valid'",
);

my $regex = qr/^(['"])(.*?)\1$/;

foreach my $inp(@tests){
if($inp =~ $regex){
say "yes";}else{say "no";}
}
