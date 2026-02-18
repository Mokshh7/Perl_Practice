use strict;
use warnings;
use feature 'say';

use DBI;

my $dsn      = "DBI:mysql:database=sql_practice_db;host=localhost";

my $dbh = DBI->connect($dsn,"root","");

my $sql1 = "SELECT product_id, product_name, price FROM products";
my $sql2 = "SELECT username FROM users";
my $select_row = $dbh->selectrow_array($sql1);
my $select_hash = $dbh->selectall_hashref($sql1,"product_id");
my @row = $dbh->selectall_array($sql2);

say @{$row[0]};


foreach(keys %$select_hash){
say $select_hash->{$_}{product_name};
#say $_->{product_name};
}
