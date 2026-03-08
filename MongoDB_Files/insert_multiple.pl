use strict;
use warnings;
use feature 'say';

use MongoDB;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db     = $client->get_database("test");
my $users  = $db->get_collection("users");

my @docs = (
    { name => "Simran", age => 22, role => "intern",    skills => ["mongo"] },
    { name => "Aman",   age => 24, role => "tester",    skills => ["sql"] },
    { name => "Riya",   age => 23, role => "analyst",   skills => ["excel"] },
    { name => "Moksh",  age => 21, role => "developer", skills => ["perl"] }
);

$users->insert_many(\@docs);

say "Inserted successfully!";
