use strict;
use warnings;
use DBI;

my $dsn  = "DBI:mysql:database=sql_practice_db;host=localhost";
my $dbh  = DBI->connect($dsn, "root", "", { RaiseError => 1, AutoCommit => 1 });

my $sth = $dbh->prepare("SELECT user_id, username, email FROM users");
$sth->execute();

my $rows = $sth->fetchall_arrayref({});


foreach my $row (@$rows) {
    print "ID=$row->{user_id} Username=$row->{username} Email=$row->{email}\n";

}


use Data::Dumper;
print Dumper($rows);

$sth->finish;
$dbh->disconnect;
