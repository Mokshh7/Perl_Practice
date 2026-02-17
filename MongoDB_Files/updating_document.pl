use strict;
use warnings;
use feature 'say';

use MongoDB;
#connecting client
my $client = MongoDB->connect("mongodb://localhost:27017");

#selecting db
my $db = $client->get_database("test");

#selecting collection
my $users = $db->get_collection("users");
my $curr = $users->find({});
while(my $docc = $curr->next){
say "$docc->{name} and $docc->{role}";
}

#updateing users
my $result = $users->update_one(
{ name => "Kabir"},
{ '$set' => { role => "ML Engeener"} }
);

my $cursor = $users->find({});

say "------------------------------------";

while(my $row = $cursor->next){
say "$row->{name} and $row->{role}";
}
