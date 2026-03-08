package validator;
use strict;
use warnings;
use feature 'say';

sub new{

my ($class) = @_;
bless {},$class;

}

sub validate_employee{

my ($self ,$row ) = @_;

return "employees_id missing" unless $row->{employee_id};
return "name missing" unless $row->{name};
return "department missing" unless $row->{department};

return "salary missing"
unless defined $row->{salary} && $row->{salary} ne '';

    return "salary not numeric"
        unless $row->{salary} =~ /^\d+$/;

    return "invalid status"
        unless $row->{status} =~ /^(active|inactive|terminated)$/;


return ;

}

1;
