use strict;
use warnings;
use feature 'say';
use DBI;
my $dns = "DBI:mysql:database=sql_practice_db;host=localhost";
my $dbi = DBI->connect($dns,"root","",{AutoCommit =>1 });
say $dbi;

my $sql1 = "create view order_payment_views as 
select 
    o.order_id,
    o.user_id,
    o.total_amount,
    o.status,
    p.payment_status,
    p.payment_method,
    p.paid_amount
from orders o 
left join payments p 
on o.order_id = p.order_id;
";
my $sql2 = "select * from order_payment_views";
my $sql3 = "create or replace view user_orders_view as 
select 
u.user_id,
u.username,
u.password,
o.order_id,
o.order_date,
o.total_amount,
o.status
from users u 
join orders o on u.user_id = o.user_id;
";
my $sql4 = "select * from user_orders_view";
#my $pp = $dbi->prepare($sql1);
#$pp->execute();
my $qq = $dbi->prepare($sql2);
$qq->execute();
my $rr = $dbi->prepare($sql3);
$rr->execute();
my $ss = $dbi->prepare($sql4);
$ss->execute();

while(my $rows = $ss->fetchrow_hashref){
use Data::Dumper;
say Dumper($rows);
}
