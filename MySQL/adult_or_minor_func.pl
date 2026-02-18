use strict;
use warnings;
use feature 'say';

use DBI;

my $dbh = DBI->connect("DBI:mysql:database=sql_practice_db;host=localhost;
mysql_multi_statements=1",
"root","")
or die $@;

my $func = qq{
create function checkage(age int )
returns varchar(20)
deterministic
begin
declare result varchar(20);

if age >= 18 then
set result = "adult";
else 
set result = "minor";
end if;

return result ;
end ;
};
$dbh->do($func);
my $ss = $dbh->prepare("select checkage(100)");
$ss->execute();

while(my $row = $ss->fetchrow_arrayref){
say @$row;
}
