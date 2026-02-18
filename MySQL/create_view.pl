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
    CREATE VIEW IF NOT EXISTS user_order_summary AS
    SELECT 
        u.user_id ,
        u.username ,
        COUNT(o.order_id) AS total
    FROM users u
    LEFT JOIN orders o 
        ON u.user_id = o.user_id
    GROUP BY u.user_id, u.username;
};


$dbh->do($sql);

my $sql2 = qq{select * from user_order_summary};

my $ss = $dbh->prepare($sql2);
$ss->execute();

while(my $row = $ss->fetchrow_arrayref){
say @$row;
}
