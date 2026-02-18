use strict;
use warnings;
use feature 'say';

use DBI;

my $db   = "sql_practice_db";
my $host = "localhost";
my $user = "root";
my $pass = "";

my $dsn = "DBI:mysql:database=$db;host=$host";

my $dbh = DBI->connect($dsn, $user, $pass, {
    RaiseError => 1,
    AutoCommit => 1,
    mysql_enable_utf8 => 1,
}) or die "DB connection failed: $DBI::errstr\n";

my $sql = qq{
select u.user_id , u.username , sum(o.order_id) as total from users u 
inner join orders o on u.user_id = o.user_id having (total < 5) ;
};

my $ss = $dbh->prepare($sql);

$ss->execute();

while (my $row = $ss->fetchrow_arrayref){
say join "|" , @$row;
}


