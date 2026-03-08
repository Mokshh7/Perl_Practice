use strict;
use warnings;
use feature 'say';

use MongoDB;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db     = $client->get_database("test");
my $users  = $db->get_collection("users");

print "Enter name: ";
chomp(my $name = <STDIN>);

$users->update_one({name => $name},{'$inc' => { salary => 1 }});
