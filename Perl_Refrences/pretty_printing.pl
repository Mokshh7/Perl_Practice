use strict;
use warnings;
use feature 'say';

my $depts = {IT => ["Alice", "Bob"],
HR => ["Riya"]};



foreach my $keys(keys %$depts){

say "$keys : @{$depts->{$keys}}";


}
