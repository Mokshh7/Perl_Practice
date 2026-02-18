use strict;
use warnings;
use feature 'say';
use DBI;

say "select db";
chomp(my $db = <STDIN>);
die if($db eq "");
my $dbi = DBI->connect(
    "DBI:mysql:database=sql_practice_db;host=localhost",
    "root",
    "",
    { RaiseError => 1, AutoCommit => 1 }
);

$dbi->do("use $db");

say "table name";
chomp(my $table_name = <STDIN>);

die if($table_name eq "");
my $sql = qq{select * from $table_name};
my $ss = $dbi->prepare($sql);
$ss->execute();

while(my $row = $ss->fetchrow_arrayref){
    say join(" | ", @$row);
}
