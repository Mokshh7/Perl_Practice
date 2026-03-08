package person;
use strict;
use warnings;
use feature 'say';

sub new{
my ($class,%args) = @_;

my $self = {
name => $args{name},
age => $args{age}
};

bless $self , $class;
return $self ;
}

sub name {$_[0]->{name}}

sub age {$_[0]->{age}}


sub describe{
my $self = shift ;

return "$self->{name} , $self->{age}";
}


sub is_senior{

my $s = shift ;
if ($s->{age} >= 60 ){
say "$s->{name} is a senior";
}
}
1,
