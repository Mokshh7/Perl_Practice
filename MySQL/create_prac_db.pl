use strict;
use warnings;
use DBI;

# -------------------------------
# STEP 1: MySQL Connection Details
# -------------------------------
my $host     = "localhost";
my $user     = "root";
my $password = "";

my $dsn = "DBI:mysql:;host=$host";

my $dbh = DBI->connect(
$dsn,$user,$password,{
RaiseError => 1,
AutoCommit => 1,
mysql_enable_utf => 1,
}
) or die "db connection failed";

say "mysql server connected sucessfully";

my $db_name = "mysql_prac_db";

$dbh->do("drop database if exists $db_name");
$dbh->do("create database $db_name");
say "database $dbname created sucessfully!";

$dbh->do("use $db_name");
say "using db $db_name";

$dbh->do("
create table users(
userid int auto_increment primary key,
username varchar(50) not null unique,
email varchar(100) not null unique,
password varchar(100) not null ,
created_at timestamp default current_timestamp
)
");

say "table users created";

$dbh->do(

)

