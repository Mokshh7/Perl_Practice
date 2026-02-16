use strict;
use feature 'say';
use warnings;
use JSON;
use XML::LibXML;

my $doc = XML::LibXML::Document->new('1.0' , 'UTF-8');
my $root = $doc->createElement('employees');
say $root ;
$doc->setDocumentElement($root);

my $emp = $doc->createElement("employee");
$emp->setAttribute(ID => 201);

for my $feild ( 
    [ name => 'Amit' ],
    [ department => 'HR' ],
    [ salary => 45000 ],
    [ status => 'active' ]
){
my $node = $doc->createElement($feild->[0]);
$node->appendTextNode($feild->[1]);
$emp->appendChild($node);

}

$root->appendChild($emp);


open my $fh , ">>" , "../output/write_xml.xml" 
or die $!;

print $fh $doc->toString(1);


