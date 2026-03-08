use strict;
use warnings;
use Test::More tests => 4;
use FindBin;
use lib "$FindBin::Bin/../lib";

use employee;

my $a = employee->new(
name => "Moksh",
age => 21,
salary => 100000000
);

ok(defined $a,"obj is created");
isa_ok($a,'person');
is($a->salary,100000000,"salary correct");
like($a->describe,qr/Moksh/, "descirbe overridden");


