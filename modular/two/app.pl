use strict;
use warnings;
use feature 'say';

use FindBin;

use lib "$FindBin::Bin/lib";
use person;

my $p = person->new(
name => "Moksh",
age => 21,
);

$p->display;
