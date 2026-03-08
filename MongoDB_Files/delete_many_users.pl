use strict;
use warnings;
use feature 'say';

use MongoDB;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db     = $client->get_database("test");
my $users  = $db->get_collection("users");

# TODO: delete_many where age < 22

$users->delete_many({age => {'$gt' => 22}});
say $users->matched_count();

