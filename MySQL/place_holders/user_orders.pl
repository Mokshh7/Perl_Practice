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

say "Enter username: ";
chomp(my $username = <STDIN>);

my $sql = "
select u.username, o.order_id, o.total_amount,o.order_date
from users u
join orders o on u.user_id = o.user_id
where u.username = ?
";

my $sth = $dbh->prepare($sql);
$sth->execute($username);

say "orders for $username ";


my $found = 0;

while(my $row = $sth->fetchrow_hashref){

    $found = 1;
    print "Order ID: $row->{order_id}\n";
    print "Total: $row->{total_amount}\n";
    print "Date: $row->{order_date}\n";
    print "-------------------------------------\n";
}

if(!$found){
say "no order found";
}
