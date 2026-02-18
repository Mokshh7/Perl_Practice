use strict;
use warnings;
use feature 'say';
use DBI;

my $database = "sampledb";
my $host = "localhost";
my $port = 3306;
my $user = "root";
my $password = "9";

my $dbh = DBI->connect("DBI:mysql:classicmodels","root",'');
#my $dsn = "DBI::mysql:database=$database;host=$host;port=$port";
say $dbh;

if(!$dbh){
die "$@";
}else{
say "connected";
}

my $sql = "SELECT customerName, country FROM customers LIMIT 5";
my $sth = $dbh->prepare($sql);
$sth->execute();

while (my $row = $sth->fetchrow_hashref) {
    say "$row->{customerName} - $row->{country}";
}

$sth->finish;
$dbh->disconnect;
say "Done.";
