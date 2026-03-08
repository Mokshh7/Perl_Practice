package engine;
use strict;
use feature 'say';
use warnings;

sub new{
my ($car_name,%attr) = @_;

my $engine = {
name => $attr{name},
power => $attr{power}
};

bless { $engine } , $car_name;
}

sub power{ $_[0]->{power} }

1;
