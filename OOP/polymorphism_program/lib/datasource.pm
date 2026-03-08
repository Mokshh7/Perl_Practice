package datasource;
use strict;
use warnings;
use feature 'say';

sub new{
my ($cnames,%args) = @_;
my $self = (
filename => $args{filename},
);
bless $self, $cname;
return $self;
}

