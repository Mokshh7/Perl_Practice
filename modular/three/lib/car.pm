package car;

use strict;
use warnings;
use feature 'say';
use engine;
sub carr{
my ($car_name , %attr) = @_;

my $engine = engine->new(power => $attr{power});

my $car = {
name => $attr{name},
engine => $engine,
};

bless $car, $car_name;
return $car;
}

sub describe{

my $self = shift;

say "car : $self->{name}";
say "engine info : $self->{engine}->power";
}

1;
