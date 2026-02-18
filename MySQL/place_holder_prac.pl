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

say "enter username to search";
my $input = <STDIN>;
chomp $input;
my $sql = "SELECT user_id, username, email, created_at FROM users WHERE username = ?";

my $sth = $dbh->prepare($sql);
$sth->execute($input);
my $row = $sth->fetchrow_hashref;
while($row){
say "user found";
say "User ID: $row->{user_id}";
say "Username: $row->{username}";
say "Email: $row->{email}";
say "Created At: $row->{created_at}";
}

$sth->finish;
$dbh->disconnect;
  
