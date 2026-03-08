use strict;
use warnings;
use feature 'say';

package vehicle;

sub new{
my ($class , %args) = @_;

my $self = {
brand => $args{brand},

};
return bless $self , $class ;
}

sub start{
my ($self) = @_;
say "Vehicle is starting";
}

1;

package car;
our @ISA= ('vehicle');

sub honk{
my ($self) = @_;
say "car horn : beep beep";
}

1;

package main ;

my $c = car->new(brand => "Toyota");

$c->start();
$c->honk();
