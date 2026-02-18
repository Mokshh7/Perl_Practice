use strict;
use feature 'say';
use warnings;
use JSON;
use DBI;

my $dsn  = "DBI:mysql:database=sql_practice_db;host=localhost";
my $dbh  = DBI->connect($dsn, "root", "", { RaiseError => 1, AutoCommit => 1 });

my $sql = "SELECT product_id, product_name, price FROM products";
open my $fahhh , ">>" , "hashref_encoding.json" or die ;
my $sth = $dbh->prepare($sql);

$sth->execute();

while(my $row = $sth->fetchrow_hashref){
my $aa = encode_json($row);
say $fahhh $aa;
}
