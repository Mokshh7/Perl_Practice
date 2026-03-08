package Animal;
use strict;
use warnings;
use feature 'say';

sub new {
    my ($class, %args) = @_;
    my $self = {
        name  => $args{name},
        energy => 100,
    };
    bless $self, $class;
}

sub eat {
    my $self = shift;
    $self->{energy} += 10;
    say "$self->{name} eats. Energy: $self->{energy}";
}

sub speak {
    say "Generic animal sound";
}

1;
