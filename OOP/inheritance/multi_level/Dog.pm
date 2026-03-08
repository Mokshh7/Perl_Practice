package Dog;
use strict;
use warnings;
use feature 'say';
use parent 'Animal';

sub new {
    my ($class, %args) = @_;

    my $self = $class->SUPER::new(%args);
    $self->{breed} = $args{breed};

    return $self;
}

sub speak {
    my $self = shift;
    $self->SUPER::speak();
    say "$self->{name} barks loudly";
}

1;
