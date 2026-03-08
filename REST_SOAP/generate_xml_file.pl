use strict;
use warnings;
use feature 'say';

use XML::Writer;
use IO::File;

my $output = IO::File->new(">device_request.xml");

my $writer = XML::Writer->new(
OUTPUT => $output,
DATA_MODE => 1,
DATA_INDENT => 2
);

$writer->xmlDecl("UTF-8");

$writer->startTag("devices");

$writer->startTag("device");

$writer->dataElement("name","router");
$writer->dataElement("ip","10.0.0.1");
$writer->endTag("device");

$writer->endTag("devices");

$writer->end();
$output->close;
