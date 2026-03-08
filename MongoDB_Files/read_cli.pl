use strict;
use warnings;
use feature 'say';

use MongoDB;

my $client = MongoDB->connect("mongodb://localhost:27017");
say "name your db";
chomp(my $dbse = <STDIN>);
my $db = $client->get_database($dbse);

say "name the collection";
chomp(my $colls = <STDIN>);

my $users  = $db->get_collection($colls);

my $result = $users->find({});

while (my $doc = $result->next()){
say $doc->{name};
say $doc->{age};
say $doc->{role};
say @{$doc->{skills}};
}
