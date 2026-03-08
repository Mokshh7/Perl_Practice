package animal;
use strict;
use warnings;
use feature 'say';

sub new {
    my ($class, %args) = @_;
    my $self = { name => $args{name} };
    bless $self, $class;
}

sub speak{
say "animal makes a sound";
}

1;

