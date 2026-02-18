use strict ;
use warnings;
use feature 'say';

use DBI;

my $dbi = DBI->connect("DBI:mysql:host=localhost","root","",
 {
        RaiseError => 1,
        AutoCommit => 1,
        PrintError => 0,
    }
) or die ;



sub validate_identifier {
    my ($name, $type) = @_;

    die "$type cannot be empty!\n" if (!defined $name || $name eq "");

    if ($name !~ /^[A-Za-z_][A-Za-z0-9_]*$/) {
        die "Invalid $type name: '$name'\nOnly letters, digits, underscore allowed.\n";
    }

    return $name;
}



say "db name";

chomp(my $db = <STDIN>);

$db = validate_identifier($db, "Database");

my $create = "
CREATE DATABASE IF NOT EXISTS $db;
";

$dbi->do($create);

say "created" ;


$dbi->do("USE $db");


say "enter table name ";
chomp(my $table_name = <STDIN>);

$table_name = validate_identifier($table_name, "Table");



#creation command
my $create_querry = "create table if not exists $table_name(
student_id int auto_increment primary key,
name varchar(100) not null,
age int not null ,
email varchar(150) unique,
created_at timestamp default current_timestamp
);";
$dbi->do($create_querry);



#insertion command
sub insertion{
say "enter name ";
chomp(my $name = <STDIN>);
say "enter age ";
chomp(my $age = <STDIN>);
say "enter email_id ";
chomp(my $email = <STDIN>);

my $update_querry = qq{insert into $table_name 
(name,age,email) values (?,?,?) 
};
my $sth = $dbi->prepare($update_querry);
$sth->execute($name,$age,$email);

}
my $yn ;
do{
insertion();
say "y/n?";
chomp($yn = <STDIN>);
}while($yn eq "y");


#reading command

my $sql = qq{select * from $table_name};
my $ss = $dbi->prepare($sql);
$ss->execute();

while(my $row = $ss->fetchrow_arrayref){
    say join(" | ", @$row);
}


sub update_student {
    say "Enter student_id to update:";
    chomp(my $id = <STDIN>);

    say "Enter new name:";
    chomp(my $name = <STDIN>);

    say "Enter new age:";
    chomp(my $age = <STDIN>);

    say "Enter new email:";
    chomp(my $email = <STDIN>);

    my $update_query = qq{
        UPDATE $table_name
        SET name = ?, age = ?, email = ?
        WHERE student_id = ?
    };

    my $sth = $dbi->prepare($update_query);
    $sth->execute($name, $age, $email, $id);

    say "Updated successfully!";
}

sub delete_student {
    say "Enter student_id to delete:";
    chomp(my $id = <STDIN>);

    my $delete_query = qq{
        DELETE FROM $table_name
        WHERE student_id = ?
    };

    my $sth = $dbi->prepare($delete_query);
    $sth->execute($id);

    say "Deleted successfully!";
}

update_student();
