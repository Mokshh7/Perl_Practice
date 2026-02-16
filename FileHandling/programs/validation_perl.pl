use strict;
use warnings;
use feature 'say';

use XML::LibXML;


my $parser = XML::LibXML->new();
$parser->load_ext_dtd(1);
$parser->validation(1);

eval{
$parser->parse_file("../data/employees.xml");
};
die if $@;
