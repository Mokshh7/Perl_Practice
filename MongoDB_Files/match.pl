use strict;
use warnings;
use feature 'say';

use MongoDB;
use Data::Dumper;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db = $client->get_database("test");
my $user = $db->get_collection("users");

my $cursor = $user->aggregate([
{ '$match' => { age => { '$gt' => 22}}}
]);

say "users age > 22";
while(my $doc = $cursor->next){
say Dumper($doc);
}
