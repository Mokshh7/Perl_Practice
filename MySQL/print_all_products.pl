use strict;
use warnings;
use feature 'say';

use DBI;

my $dsn = "DBI:mysql:database=sql_practice_db;host=localhost";
my $user = "root";
my $password = "";

my $dbh = DBI->connect($dsn,$user,$password);

my $sql =  "SELECT product_id, product_name, price, stock FROM products";

my $sth = $dbh->prepare($sql);
$sth->execute();

while(my @row = $sth->fetchrow_array){
my ($id , $name , $price , $stock) = @row;

say "ID: $id | Name: $name | Price: $price | Stock: $stock\n";
}

$sth->finish();
$sth->disconnect();

