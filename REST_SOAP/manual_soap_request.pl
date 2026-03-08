use strict;
use warnings;
use feature 'say';

use LWP::UserAgent;

my $xml = <<'XML';
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xmlns:xsd="http://www.w3.org/2001/XMLSchema"
xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">

<soap:Body>
<Add xmlns="http://tempuri.org/">
<intA>10</intA>
<intB>25</intB>
</Add>
</soap:Body>
</soap:Envelope>
XML

my $ua = LWP::UserAgent->new;

my $response = $ua->post(
"http://www.dneonline.com/calculator.asmx",
Content_Type => 'Text/xml',
Content => $xml
);

say $response->decoded_content;


