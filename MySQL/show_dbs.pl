use strict;
use warnings;
use feature 'say';

use DBI;

my $dbi = DBI->connect("DBI:mysql:host=localhost","root","");
my $ss = $dbi->prepare("show databases");
$ss->execute();


while(my $row = $ss->fetchrow_arrayref()){
say @$row;
}
