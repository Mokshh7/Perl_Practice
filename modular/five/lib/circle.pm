package circle;
use strict;
use warnings;
use feature 'say';
use parent 'shape';
sub area{
my ($self) = @_;
return 3.14159 * $self->{radius} ** 2;
}

sub describe{
return "i am a circle";
}

1;
