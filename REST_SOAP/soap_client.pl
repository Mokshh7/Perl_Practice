use strict;
use warnings;
use feature 'say';

use SOAP::Lite;

my $soap = SOAP::Lite->uri('http://tempuri.org/')->proxy('http://www.dneonline.com/calculator.asmx');

my $result = $soap->call('Add',
SOAP::DATA->name(intA => 10),
SOAP::DATA->name(intB => 20)
);

if(result->fault){
die "SOAP Fault : " . $result->faultstring;
}

say "Result : " , $result->result;
