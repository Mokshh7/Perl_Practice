use strict;
use warnings;
use feature 'say';

use XML::LibXML::Reader;

my $reader = XML::LibXML::Reader->new(location => 'log_xml.xml');

while($reader->read){

if ($reader->nodeType == 1 && $reader->name eq 'event'){
my $node = $reader->copyCurrentNode(1);

my $type = $node->findvalue('./type');
my $user = $node->findvalue('./user');
say "Type : $type";
say "User : $user";
}
}
