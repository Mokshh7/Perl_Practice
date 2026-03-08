use strict;
use warnings;
use feature 'say';
use FindBin;
use lib "$FindBin::Bin/lib";

use person;
use employee;

my $p = person->new(name => "Moksh",age => 21);
my $e = employee->new(name =>"Riya",age =>28,salary => 70000);
my $f = employee->new(name =>"Siya",age =>60,salary => 70000);

say $p->describe;
say $e->describe;
say $f->describe;
foreach ($p,$e,$f){
$_->is_senior;
}
