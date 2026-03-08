use strict;
use warnings;
use feature 'say';

use MongoDB;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db = $client->get_database("test");
my $users = $db->get_collection("users");

say "Enter name";
chomp(my $name = <STDIN>);

say "Enter age: ";
chomp(my $age = <STDIN>);

say "Enter role: ";
chomp(my $role = <STDIN>);

my $res = $users->update_one({name => $name},{ '$set' => {age => $age, role => $role} }, {upsert => 1});

say "Matched: " . $res->matched_count;
say "Modified: " . $res->modified_count;
say "Upserted ID: " . ($res->upserted_id // "none");
