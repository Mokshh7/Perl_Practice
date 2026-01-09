use strict;
use warnings;
use feature 'say';

my $template = "Hello {name}, welcome to {city}!";


my %data = (name => "alex" , city => "bengaluru"); 


 my $message = $template ; 
$message  =~ s/({name}|{city})/ $1 eq "{name}" ? $data{$name} : $data{city} /gex;

say $message;

