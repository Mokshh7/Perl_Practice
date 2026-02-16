use strict;
use warnings;
use feature 'say';
use JSON::PP;


open (my $fhh , "<" , "../output/json_output.json")
or die $!;

local $/;

my $data = readline($fhh);

close $fhh ;
my $dd = decode_json($data);
if($dd->{active} == 1){say "yes";}


