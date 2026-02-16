use strict;
use warnings;
use feature 'say';

use XML::LibXML;
use XML::LibXML::Schema;

my $schema = XML::LibXML::schema->new(
location => '../data/employee.xsd'
);

my $parser = XML::LibXML->new();
my $doc = $parser->parser_file('../data/employees.xml');

eval{
$schema->validate($doc);
};

die "$@";



