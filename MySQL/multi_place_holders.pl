use strict;
use warnings;
use feature 'say';

use DBI;


my $dsn      = "DBI:mysql:database=sql_practice_db;host=localhost";
my $user     = "root";
my $password = "";

my $dbh = DBI->connect(
    $dsn,
    $user,
    $password,
    { RaiseError => 1, AutoCommit => 1, mysql_enable_utf8 => 1 }
);

print "Enter category: ";
chomp(my $category = <STDIN>);

print "Enter max price: ";
chomp(my $max_price = <STDIN>);


my $sql = "

    SELECT product_id, product_name, category, price, stock
    FROM products
    WHERE category = ? AND price <= ?
";
my $sql2 = "select category from products";
my $row = $dbh->selectall_arrayref($sql2);
my $sth = $dbh->prepare($sql);
$sth->execute($category, $max_price);
while (my $row = $sth->fetchrows_hashref){
say "id : $row->{product_id}";
say "name : $row->{product_name}";
say "category : $row->{category}";
say "price : $row->{price}";
say "stock : $row->{stock}";
}

$sth->finish;
$dbh->disconnect;
