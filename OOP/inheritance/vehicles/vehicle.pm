package vehicle;
use strict;
use warnings;
use feature 'say';

sub new{
my ($cname,%args) = @_;

my $self = {
name => $args{name},
colour => $args{colour}
};

return bless $self,$cname;
}

sub noise{
say "this vehicle is making some unknown nosie";
}
 1;

