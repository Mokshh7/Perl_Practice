use strict;
use warnings;
use feature 'say';

use JSON::PP qw(decode_json);
use JSON::Validator;
use Scalar::Util qw(looks_like_number);

my $input = "../data/employees.json";
my $schema = "../data/employee_schema.json";

open(my $fh , "<" , $input)
or die "$!";

local $/;
my $json_text = readline($fh);
close $fh;


my $data ;
eval{

$data = decode_json($json_text);

};

if ($@) {
    die "invalid json: $@";
}

my $validator = JSON::Validator->new;
$validator->schema($schema);

my @schema_errors = $validator->validate($data);
if(@schema_errors){
say "SCHEMA ERRORS: ";
say $_ for @schema_errors;
exit 1;
}

my (@valid,@invalid);

for my $row (@$data){
my $err = deep_validation($row);
if ($err){push (@invalid,{error => $err , data => $row});}
else{push (@valid,$row);}
}

say "valid records : " ,scalar @valid;
say "invalid records : " ,scalar @invalid;
