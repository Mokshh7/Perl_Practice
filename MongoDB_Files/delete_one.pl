use strict;
use warnings;
use feature 'say';

use MongoDB;

my $client = MongoDB->connect("mongodb://localhost:27017");

say "enter db";
chomp(my $database = <STDIN>);
my $db = $client->get_database($database);

say "enter collection name";
chomp(my $collection = <STDIN>); 
my $users = $db->get_collection($collection);

say "enter the name of the document to delete";
chomp(my $name = <STDIN>);
my $cursor = $users->delete_one({name => $name});

say "Deleted" . $cursor->deleted_count;
