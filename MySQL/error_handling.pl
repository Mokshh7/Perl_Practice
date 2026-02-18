use strict;
use warnings;
use feature 'say';
use DBI;

my $host = "localhost";
my $db   = "testdb";
my $user = "root";
my $pass = "";
my $dbh;
my $dsn = "DBI:mysql:database=$db;host=$host";
eval{
my $dbh = DBI->connect($dsn,$user,$pass,{
RaiseError => 1,
PrintError => 0,
AutoCommit => 1
});

say "connected sucessfully";

};

if ($@){
die "connection failed $@";
}

eval{
my $sth = $dbh->prepare("select now()");
$sth->execute();

while (my @row = $sth->fetchrow_array){
say "servertime = @row";
}
$sth->finish();
};



if($@){
die "query failed";
}

eval {
    $dbh->disconnect();
    print "✅ Disconnected successfully!\n";
};

if ($@) {
    warn "⚠️disconnect error: $@";
}
 
