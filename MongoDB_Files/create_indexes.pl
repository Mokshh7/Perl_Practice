use strict;
use warnings;
use feature 'say';

use MongoDB;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db     = $client->get_database("test");
my $users  = $db->get_collection("users");

say "Creating indexes...";

$users->indexes->create_one([name => 1]);
$users->indexes->create_one([ age => 1]);
$users->indexes->create_one([ role => 1, age => -1 ]);
$users->indexes->create_one([ skills => 1 ]);

say "Indexes created sucessfully";
