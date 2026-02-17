use strict;
use warnings;
use feature 'say';

use MongoDB;
use Data::Dumper;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db     = $client->get_database("test");
my $users  = $db->get_collection("users");

my $cursor = $users->aggregate([
{'$sort' => { age => -1 }}
]);

say "sorted by age desc";

while(my $doc = $cursor->next){
say Dumper($doc);
}
