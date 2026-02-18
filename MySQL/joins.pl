use strict;
use warnings;
use feature 'say';
use XML::LibXML;
use XML::Simple;
use DBI;

my $dns = "DBI:mysql:database=sql_practice_db;host=localhost";
my $dbi = DBI->connect($dns,"root","");
say $dbi;

my $sql = "select u.username, o.order_id, o.total_amount, o.order_date
from users u 
inner join orders o 
on u.user_id = o.user_id" ;

my $pp = $dbi->prepare($sql);
$pp->execute();

use Data::Dumper;

open my $fh , ">" , "joins.xml" or die ;

say $fh "<root>";

while (my $row = $pp->fetchrow_hashref) {
    my $xml = XMLout($row, RootName => 'order', NoAttr => 1, XMLDecl => 0);
    say $fh $xml;
}


say $fh "</root>";
close $fh;


