use strict;
use warnings;
use feature 'say';

use MongoDB;
use Data::Dumper;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db     = $client->get_database("test");
my $users  = $db->get_collection("users");

print "Enter skill: ";
chomp(my $skill = <STDIN>);

my $result = $users->find({skills => $skill});

while (my $doc = $result->next()){
say $doc->{name};
say $doc->{role};
}


