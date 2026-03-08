package Puppy;
use strict;
use warnings;
use feature 'say';
use parent 'Dog';

sub play {
    my $self = shift;
    $self->{energy} -= 20;
    say "$self->{name} plays. Energy: $self->{energy}";
}

sub speak {
    say "High-pitched puppy yelp";
}

1;
