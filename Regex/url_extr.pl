use strict;
use warnings ;
use feature 'say';


sub urlext{
my ($id) = @_;

if($id =~ m{^https?://([^/]+)(/.*)$}){

say "$1 $2  ";
}



}
my $url = "https://example.com/products/item1" ;

urlext($url);
