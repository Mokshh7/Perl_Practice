use strict;
use warnings;
use feature 'say';

use MongoDB;
use Data::Dumper;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db = $client->get_database("test");
my $user = $db->get_collection("users");

my $cursor = $user->aggregate([
{
'$group' => {
_id => '$role',
avgAge => { '$avg' => '$age'},
minAge => {'$min' => '$age'},
maxAge => {'$max' => '$age'}
}
}
]);

say "Age stats per role :";
say "---------------------------------------";
while (my $doc = $cursor->next){
foreach(keys %$doc){  say "$_ -> $doc->{$_}" ; }
}
