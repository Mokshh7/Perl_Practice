package car;
use strict;
use warnings;
use feature 'say' ;
use parent 'vehicle';

sub new{
my ($cname,%args) = @_;

my $self = {
name => $args{name},
colour => $args{colour}
};

return bless $self,$cname;
}

sub noise{
say "this is a car";
}
1;

