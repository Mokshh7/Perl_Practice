use strict;
use warnings;
use feature 'say';

use MongoDB;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db     = $client->get_database("test");
my $users  = $db->get_collection("users");

my @docs = (
{name => "shivam" , age => 22 , role => "intern"},
{name => "vedant" , age => 24 , role => "tester"},
{name => "riya" , age => 23 , role => "analyst"},
);

my $result = $users->insert_many(\@docs);

say "Inserted IDs";
say $_ for @{$result->inserted_ids};
