use strict;
use warnings;
use feature 'say';

my $host = "localhost";   # default
my $config = { db => {host => 1} };

if (defined $config && defined $config->{db} && defined $config->{db}->{host}) {
    $host = $config->{db}->{host};
}

say $host;

