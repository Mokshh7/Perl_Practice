use strict;
use warnings;
use feature 'say';

use FindBin;
use lib "$FindBin::Bin/lib";

use car;

my $car = car->carr(
name => "toyota",
engine => 150
);

$car->describe;

