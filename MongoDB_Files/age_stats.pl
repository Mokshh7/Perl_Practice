use strict;
use warnings;
use feature 'say';

use MongoDB;
use Data::Dumper;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db = $client->get_database("test");
my $users = $db->get_collection("users");

my $result = $users->aggregate([
{
'$group' =>{
_id => undef,
avg_age =>{'$avg' => '$age' } ,
min_age => {'$min' => '$age'},
max_age => {'$max' => '$age'},
total_users => {'$sum' => 1}
}
}
]);


$result = $result->next;

say " average age : $result->{avg_age}";
say " maximum age : $result->{max_age}";
say " minimum age : $result->{min_age}";
say " total users : $result->{total_users}";


