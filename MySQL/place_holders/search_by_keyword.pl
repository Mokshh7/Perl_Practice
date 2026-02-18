use feature 'say';
use strict;
use warnings;
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

say "enter keyword";

chomp(my $keyword = <STDIN>);

my $sql = "
select product_id, product_name, price from products 
where product_name like ?
";

my $sth = $dbh->prepare($sql);
$sth->execute("%$keyword%");

say "matching products : ";

while(my $row = $sth->fetchrow_hashref){
say "ID $row->{product_id} | name : $row->{product_name} | price : $row->{price}";
}

$sth->finish;
$dbh->disconnect;
