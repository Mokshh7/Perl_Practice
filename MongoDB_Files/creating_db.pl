use strict;
use warnings;
use feature 'say';

use JSON;
use MongoDB;

open my $fh , "<" , "data/big_json_file.json"
or die;

use Data::Dumper;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db     = $client->get_database("new_database");
my $users  = $db->get_collection("users");

local $/;

my $input = <$fh>;
my $result = decode_json($input);
$users->insert_many($result);

close $fh;
