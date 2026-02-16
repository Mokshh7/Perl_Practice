use strict;
use warnings;
use feature 'say';

use JSON;
open my $fh , "<" , "json_files/employees.json";
local $/;
my $text = readline($fh);
my $json = from_json($text);


