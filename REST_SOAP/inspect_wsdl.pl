use strict;
use warnings;
use feature 'say';

use SOAP::Lite;

my $wsdl = 'http://www.dneonline.com/calculator.asmx?WSDL';

my $soap =  SOAP::Lite->service($wsdl);

say "Available methods : ";

foreach my $method($soap->method){
say "$method";
}
