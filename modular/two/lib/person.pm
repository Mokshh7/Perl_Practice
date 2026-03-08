package person;
use strict;
use warnings;
use feature 'say';
#use FindBin;
#use lib "$FindBin::Bin/lib";
sub new{
my ($cname,%attr) = @_;

my $self = {
name => $attr{name},
age => $attr{age},
};

bless $self,$cname;
return $self;

}

sub display{
my $self = shift;
say "name : $self->{name} " ;
#say "$_[0]->{age}";
} 

1;
