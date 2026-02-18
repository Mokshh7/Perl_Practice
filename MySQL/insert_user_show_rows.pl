
use strict;
use warnings;
use DBI;

my $dsn  = "DBI:mysql:database=sql_practice_db;host=localhost";
my $dbh  = DBI->connect($dsn, "root", "", { RaiseError => 1, AutoCommit => 1 });

print "Enter username: ";
chomp(my $username = <STDIN>);

print "Enter email: ";
chomp(my $email = <STDIN>);

print "Enter password: ";
chomp(my $password = <STDIN>);

my $sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";

my $sth = $dbh->prepare($sql);
$sth->execute($username, $email, $password);

my $rows_inserted = $sth->rows;



print "\nRows inserted: $rows_inserted\n";

$sth->finish;
$dbh->disconnect;
