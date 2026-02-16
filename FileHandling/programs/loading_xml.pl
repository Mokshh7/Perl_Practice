use strict;
use warnings;
use feature 'say';

use XML::LibXML;

my $doc = XML::LibXML->load_xml(location => '../data/employees.xml');

for my $emp ($doc->findnodes('./employees/employee')){

say $emp->findvalue('./id');

}
