use strict;
use warnings;
use feature 'say';

use DBI;

my $dbh = DBI->connect("DBI:mysql:database=sql_practice_db;host=localhost;
mysql_multi_statements",
"root","")
or die $@;

my $sql = qq{
create function add_two(a int , b int )
returns int
deterministic
return a + b;
};


$dbh->do($sql);



my $ss = $dbh->prepare("select add_two(1,2)");
$ss->execute();
while(my $row = $ss->fetchrow_arrayref){
say join "|" , @$row;
}
