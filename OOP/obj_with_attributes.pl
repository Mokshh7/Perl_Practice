use strict;
use warnings;
use feature 'say';

package Person;

sub new{

my ($class, %args) = @_;

my $self = {

name => $args{name},
age => $args{age},
};

bless $self,$class;
return $self;
}

sub display{
my $self = shift;
say "name : $self->{name}";
say "age : $self->{age}";
}

package main;

my $p = Person->new(
name => "Moksh",
age => 21
);

$p->display();

