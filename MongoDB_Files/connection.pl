use strict;
use warnings;
use feature 'say';

use MongoDB;

#creating client connection
my $client = MongoDB->connect("mongodb://localhost:27017");

#selecting db

my $db = $client->get_database("test");

#set collection
my $users = $db->get_collection("users");

#insert a document 
my $result = $users->insert_one({
name => "Moksh",
age => 21,
role => "developer",
skills => ["perl","Mysql","mongodb"]
});

say "inserted ID" . $result->inserted_id;

#fetch all documents
my $cursor = $users->find({});

say "users in collection:";

while (my $doc = $cursor->next){
say "Name : $doc->{name} , age : $doc->{age} , role : $doc->{role}";
}
