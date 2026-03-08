use strict;
use warnings;
use feature 'say';
use lib "." ;

use dog ;

my $dog = dog->new(name => "Tommy");
$dog->speak();


