use strict;
use warnings;
use feature 'say';

my $reff = { host => "localhost", port => 5432 };


foreach(keys %{$reff}){

say "$_ => $reff->{$_}";

}
