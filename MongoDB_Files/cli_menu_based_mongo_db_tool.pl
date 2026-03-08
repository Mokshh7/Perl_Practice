use strict;
use warnings;
use feature 'say';

use MongoDB;
my $client = MongoDB->connect("mongodb://localhost:27017");
my $db = $client->get_database("test");
my $users = $db->get_collection("users");

while (1){
 say "\n===== USER MANAGEMENT MENU =====";
    say "1. Insert User";
    say "2. Show All Users";
    say "3. Find Users By Role";
    say "4. Delete User By Name";
    say "5. Exit";
say "Enter your choice: ";

chomp(my $choice = <STDIN>);

if($choice == 1){
say "Enter name: " ; 
chomp(my $name = <STDIN>);

say "Enter age: " ;
chomp(my $age = <STDIN>);

say "Enter role: " ;
chomp(my $role = <STDIN>);
$users->insert_one({
name => $name ,
age => $age,
role => $role
});


}elsif($choice == 2 ){

my $result = $users->find({}); 

while(my $row = $result->next){

foreach(keys %$row){

say "$_ -> $row->{$_}";

 }}}
elsif($choice == 3){
say "enter role";
chomp(my $role = <STDIN>);
my $result = $users->find({role => $role});

while(my $row = $result->next){

foreach(keys %$row){

say "$_ -> $row->{$_}";

 }}

}
elsif($choice == 4 ){
say "enter id to delete";
chomp(my $id = <STDIN>);
$users->delete_one({id => $id })
}
else{
say "Invalid choice";
last;
}
}
