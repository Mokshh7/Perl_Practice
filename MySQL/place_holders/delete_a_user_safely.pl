use strict;
use warnings;
use feature 'say';

use DBI;

my $dsn = "DBI:mysql:database=sql_practice_db;host=localhost";
my $pass = "";
my $user = "root";

my $dbh = DBI->connect(
$dsn,$user,$pass,{RaiseError => 1, AutoCommit => 1}
);

say "enter user_id to delete";

 chomp(my $uid = <STDIN>);


my $sql = "delete from users where user_id = ?";
my $sql2 = "select * from users where user_id = ?";


my $rows = $dbh->selectall_arrayref($sql2);
say @$rows;

my $sth = $dbh->prepare($sql);
$sth->execute($uid);
say "user deleted ";


$sth->finish;
$dbh->disconnect;

