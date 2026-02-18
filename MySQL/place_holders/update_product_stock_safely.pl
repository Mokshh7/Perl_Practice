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

print "Enter product ID: ";
chomp(my $pid = <STDIN>);

print "Enter new stock value: ";
chomp(my $stock = <STDIN>);  

my $sql = "update products set stock = ? where product_id = ?";

my $sth = $dbh->prepare($sql);
$sth->execute($stock,$pid);

say "stock updated sucessfully ";

$sth->finish;
$dbh->disconnect;


