use strict;
use feature 'say';
use warnings;
use JSON;
use JSON::Streaming::Reader;

open(my $fh , '<','huge_employees.json')
 or die $!;

my $reader = JSON::Streaming::Reader->for_stream($fh);

while(my $item = $reader->get_item){
say "ID : ",$item->{id};
}

close $fh;
