use feature 'say';

use strict;
use warnings;
use DBI;

my $dsn  = "DBI:mysql:database=sql_practice_db;host=localhost";
my $dbh  = DBI->connect($dsn, "root", "", { RaiseError => 1, AutoCommit => 1 });

say "Enter username: ";
chomp(my $username = <STDIN>);

say "Enter email: ";
chomp(my $email = <STDIN>);

say "Enter password: ";
chomp(my $password = <STDIN>);

my $sql = "insert into users (username, email, password) values (?,?,?)";

my $sth = $dbh->prepare($sql);
$sth->execute($username,$email,$password);

say "user inserted successfully";
$sth->finish;
$dbh->disconnect;
