use strict;
use warnings;
use feature 'say';

use MongoDB;

my $client = MongoDB->connect("mongodb://localhost:27017");

my $db = $client->get_database("test");

my $users = $db->get_collection("users");


my $curr = $users->find({});
while(my $doc = $curr->next){
say $doc->{name};
}

#my $result = $users->delete_one({
#name => "Moksh" 
#});
say "------------------------";
my $cursor = $users->find({});
while(my $doc = $cursor->next){
say $doc->{name};
}
