use strict;
use warnings;
use feature 'say';

package car;

sub new{

my ($cname , $data ) = @_;

my $self = {
colour => $data->{colour},
name => $data->{name}
};

return bless $self , $cname;
}

1;

my $car = car->new({name => "Scorpio" , colour => "Black"});


say $car->{name};
