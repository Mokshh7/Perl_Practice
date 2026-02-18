 use strict;
use warnings;
use feature 'say';
use DBI;

my $host = "localhost";
my $db   = "sql_practic_db";
my $user = "root";
my $pass = "";
my $dbh;
my $dsn = "DBI:mysql:database=$db;host=$host;multi_line_statements=1";

my $dbh = DBI->connect($dsn,$user,$pass,{
RaiseError => 1,
PrintError => 0,
AutoCommit => 1
});

say "enter table name";
my $name = <STDIN>;

my $sql = qq{
create function display_cols(tablee varchar)
returns text
deterministic 
begin 
declare txt;
return select * from tablee;
end 
};
