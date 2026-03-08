use strict;
use warnings;
use feature 'say';
use JSON;
use MongoDB;
use Data::Dumper;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db     = $client->get_database("Perl");
my $users  = $db->get_collection("users");

open my $fh , "<" , "data/json_data.json"
or die $!;
local $/;

my $content = readline($fh);

my $data = decode_json($content);

foreach my $doc(@$data){
$users->insert_one($doc);
say "$doc->{name}";
}

say "json data imported successfully";
