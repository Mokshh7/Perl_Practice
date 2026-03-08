use strict;
use warnings;
use lib '.';

use Puppy;

my $p = Puppy->new(name => "Tiny", breed => "Beagle");

$p->eat();
$p->play();
$p->speak();
