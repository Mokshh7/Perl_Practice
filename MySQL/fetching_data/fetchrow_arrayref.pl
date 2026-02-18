use feature 'say';

use strict;
use warnings;
use DBI;

my $dsn  = "DBI:mysql:database=sql_practice_db;host=localhost";
my $dbh  = DBI->connect($dsn, "root", "", { RaiseError => 1, AutoCommit => 1 });

my $sql = "select product_id , product_name , price from products";

my $sth = $dbh->prepare($sql);
$sth->execute();

while(my $row = $sth->fetchrow_arrayref){
my ($id , $name , $price) = @$row;
say "id = $id | $name | $price";
}

$sth->finish;
$dbh->disconnect;
