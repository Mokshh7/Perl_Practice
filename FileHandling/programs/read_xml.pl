use strict;
use warnings;
use feature 'say';
use XML::LibXML;

my $file = shift or die ;

my $parser = XML::LibXML->new();
my $doc = $parser->parse_file($file);


my @employees = $doc->findnodes('/employees/employee');

foreach my $ff (@employees){

my $id = $ff->findvalue("./id");
say $id;
}

