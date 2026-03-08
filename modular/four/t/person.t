use strict;
use warnings;
use feature 'say';

use Test::More tests => 3;

use FindBin;
use lib "$FindBin::Bin/../lib";

use person;

my $p = person->new(name => "amit" , age => 65);

ok(defined $p, "person obj is created");
is($p->name,"amit","name is correct");

ok($p->is_senior, "Person is senior");
