use strict;
use feature 'say';
use warnings;

my $ref = [
{ id => 1, name => "Alice" },
{ id => 2, name => "Bob" }
];


foreach(@{$ref}){

say "$_->{name}";

}
