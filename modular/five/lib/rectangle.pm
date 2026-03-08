package rectangle;
use strict;
use warnings;
use feature 'say';
use parent 'shape';
sub area{
my ($self) = @_;
return $self->{width} * $self->{height};
}

sub describe{
return "I am a rectangle";
}

1;
