use strict;
use warnings;
use feature 'say';

use XML::LibXML;

my $doc = XML::LibXML->load_xml(location => "kpi.xml");

foreach my $router ($doc->findnodes('//router')){

my $name = $router->getAttribute('name');
my $cpu = $router->findvalue('./cpu');
my $memory = $router->findvalue('./memory');

say "Router : $name";
say "CPU : $cpu";
say "Memory : $memory";

}
