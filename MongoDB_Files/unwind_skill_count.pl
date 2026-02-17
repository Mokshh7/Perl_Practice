use strict;
use warnings;
use feature 'say';

use MongoDB;
use Data::Dumper;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db     = $client->get_database("test");
my $users  = $db->get_collection("users");

my $cursor = $users->aggregate([
{'$unwind' => '$skills' },
{
'$group' => {
_id => '$skills',
total => {'$sum' => 1}
}
},
{'$sort' => {total => -1}}
]);

say "Skill Frequency";
say "---------------------------------------";
while (my $doc = $cursor->next){
foreach(keys %$doc){  say "$_ -> $doc->{$_}";}
}
