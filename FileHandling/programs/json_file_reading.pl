use strict;
use warnings;
use feature 'say';
use JSON::PP;

open my $fh , "<" , "../data/json_content.json" 
or die $!;
open (my $fhh , ">>" , "../output/json_output.json")
or die $!;

local $/;

my $json_text = readline($fh);
close $fh;

my $data = decode_json($json_text);
#say $data->{employees}->[0]->{id};

#say $data->{employees}->[0]->{name};

my $out = {
  id     => 101,
  name   => "Moksh",
  active => JSON::PP::true
};

my $json = JSON::PP->new
->utf8
->canonical
->pretty;

say $json->encode($out);
my $dd = encode_json($json_text);
#say  pretty_json($dd); 
close $fhh;
