use strict;
use warnings;
use feature 'say';

use SOAP::Lite;

SOAP::Lite->import( +trace => 'all' );

my $service = SOAP::Lite
    ->service('http://www.dneonline.com/calculator.asmx?WSDL');

my $result = $service->Multiply(6, 7);

print "Result = $result\n";
