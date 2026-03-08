use strict;
use warnings;
use lib '.';

use car;

my $c = car->new(
    name   => "Audi",
    colour => "Red"
);

$c->noise();
