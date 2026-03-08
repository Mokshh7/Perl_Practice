package employee;

use strict;
use warnings;
use feature 'say';


sub new {
my ($class,%args) = @_;

  my $self = {
        employee_id => $args{employee_id},
        name        => $args{name},
        department  => $args{department},
        salary      => $args{salary},
        status      => $args{status},
    };

bless $self,$class;
return $self;
}


sub employee_id{ $_[0]->{employee_id}}
sub name{ $_[0]->{name}}
sub department{ $_[0]->{department}}
sub salary{ $_[0]->{salary}}
sub status{ $_[0]->{status}}

1;




