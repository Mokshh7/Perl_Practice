use strict;
use warnings;
use feature 'say';

use MongoDB;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db     = $client->get_database("test");
my $users  = $db->get_collection("users");

$users->indexes->create_one([name=>1],{unique => 1});    

eval{
$users->insert_one({name => "Moksh"});
};

if ($@) {
    say "Duplicate prevented!";
    say $@;
}
