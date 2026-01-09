use strict;
use warnings;
use feature 'say';

my $input = '{"a":1,"b":2,"c":3}';

my @extraction ;

if( $input =~ /("\w":\d)+(,"\w":\d)+/g){
say "$&"; 
}
