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

say "enter new username: ";
chomp(my $username = <STDIN>);

say "enter new email: ";
chomp(my $email = <STDIN>);

say "enter new password: ";
chomp(my $pass = <STDIN>);

my $sql = "insert into users (username, email, password) values (?,?,?)";

my $sth = $dbh->prepare($sql);
$sth->execute($username,$email,$pass);

say "user inserted sucessfully";

$sth->finish;
$dbh->disconnect;
