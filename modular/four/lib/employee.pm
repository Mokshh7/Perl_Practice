package employee;
use strict;
use warnings;
use feature 'say';

use parent 'person';

sub new {
my ($class, %args) = @_;

my $self = $class->SUPER::new(%args);

$self->{salary} = $args{salary};

return $self;
}

sub salary {$_[0]->{salary}}

sub describe{
my $self = shift;
return "$self->{name},$self->{age},$self->{salary}" ; 
}

1;
