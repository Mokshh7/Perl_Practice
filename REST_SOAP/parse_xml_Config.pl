use strict;
use warnings;
use feature 'say';

use XML::LibXML;

my $file = "xml_file.xml";

my $parser = XML::LibXML->new();
my $doc = $parser->parse_file($file);


foreach my $device ($doc->findnodes('/devices/device')){

my $name = $device->findvalue('./name');
my $ip = $device->findvalue('./ip');
my $loc = $device->findvalue('./location');

say "Device : $name ";
say "IP : $ip ";
say "Location : $loc";
}
