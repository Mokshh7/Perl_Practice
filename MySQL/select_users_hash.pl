use strict;
use warnings;
use feature 'say';

use DBI;

my $dsn = "DBI:mysql:database=sql_practice_db;host=localhost";
my $user = "root";
my $password = "";

my $dbh = DBI->connect($dsn,$user,$password,{
RaiseError => 1, 
AutoCommit => 1
});

my $sql = "select user_id, username, email, created_at from users";

my $sth = $dbh->prepare($sql);

$sth->execute();

while(my $row = $sth->fetchrow_hashref){

    say "User ID: $row->{user_id}";
    say "Username: $row->{username}";
    say "Email: $row->{email}";
    say "Created At: $row->{created_at}";
}

$sth->finish();
$sth->disconnect();
