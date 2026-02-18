use strict;
use warnings;
use feature 'say';

use DBI;

my $db = "classicmodels";
my $username = "root";
my $host = "localhost";

my $dbh = DBI->connect("DBI:mysql:$db",$username,"");

my $sth = $dbh->prepare("SELECT lastname, firstname , extension FROM employees")
or die ;

$sth->execute() or die $!;

my ($lname,$fname,$ext);

while(($lname,$fname,$ext) = $sth->fetchrow()){
say ("$lname, $fname	$ext");
}

$sth->finish();
$dbh->disconnect();
