use strict;
use warnings;
use feature 'say';

use DBI;
my $dbh = DBI->connect("DBI:mysql:database=sql_practice_db;host=localhost"
,"root","",{
   RaiseError => 1,
    AutoCommit => 0,   # transaction mode
    PrintError => 0,
}) or die ;

eval{
 my $username = "mokshhhhh";
    my $email    = "moksh\@gmaill.com";
    my $password = "pass123";

my $sql = qq{
insert into users (username,email,password)
values (?,?,?)
};

my $sth_user = $dbh->prepare($sql);
$sth_user->execute($username, $email, $password);

my $user_id = $dbh->{mysql_insertid};

my $total_amount = 4700;

my $insert = "
insert into orders (user_id , total_amount , order_date)
values(?,?,now())
";

my $pp = $dbh->prepare($insert);
$pp->execute($user_id,$total_amount);


    my $order_id = $dbh->{mysql_insertid};

    say "Order inserted successfully!";
    say "Generated order_id = $order_id (linked to user_id = $user_id)";

$dbh->commit();
};



if ($@) {
    say "ERROR occurred: $@";
    $dbh->rollback();
    say "Transaction rolled back!";
}


$dbh->disconnect();

