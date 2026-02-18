use strict;
use warnings;
use feature 'say';

use DBI;

# -------------------------------
# STEP 1: MySQL Connection Details
# -------------------------------
my $host     = "localhost";
my $user     = "root";
my $password = "";

my $dsn = "DBI:mysql:database=sql_practice_db;host=$host";

my $dbh = DBI->connect(
$dsn,$user,$password,{
RaiseError => 1,
AutoCommit => 1,
mysql_enable_utf => 1,
}
) or die "db connection failed";

say "mysql server connected sucessfully";

my $sql = '
create procedure add_products(
in pname varchar(100),
in cat varchar(50),
in pprice decimal(10,2),
in pstk int
)
begin 
insert into products(product_name , category , price , stock)
values (pname , cat , pprice , pstk );
end 
';

my $ss = $dbh->prepare($sql);
$ss->execute() ;

my $sth = $dbh->prepare("CALL add_prod(?, ?, ?, ?)");
$sth->execute("Keyboard","accessories","1500","20");

my $sql2 = "select * from products";
my $rr = $dbh->prepare($sql2);
$rr->execute();

while(my $rows = $rr->fetchrow_hashref){
use Data::Dumper;
say Dumper($rows);
}




