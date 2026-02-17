use strict;
use warnings;
use feature 'say';

use MongoDB;
use DateTime;

my $client = MongoDB->connect("mongo://localhost:27017");
my $db = $client->get_database("test");
my $users = $db->get_collection("users");

my $result = $users->insert_one({
name => "Kartikeya",role      => "developer",
    isActive  => 1,
    skills    => ["perl", "mongodb", "linux"],
    address   => {
        city    => "Chandigarh",
        pincode => 160017
    },
    createdAt => DateTime->now,
});

say "inserted ID: " . $result->inserted_id;

