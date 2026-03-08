use strict;
use warnings;
use feature 'say';

use MongoDB;
use DateTime;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db     = $client->get_database("test");
my $users  = $db->get_collection("users");
