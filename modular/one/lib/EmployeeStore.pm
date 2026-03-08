package EmployeeStore;

use strict;
use warnings;
use feature 'say';
use Text::CSV;
use employee;
use validator;


sub new{
my ($class) = @_;

my $self = {
employees => [],
errors =>[],
validator => validator->new,
};

bless $self , $class;
return $self;
}

sub load_from_csv{
my ($self,$file) = @_;

open my $fh , "<" , $file or die ;
my $csv = Text::CSV->new({
binary => 1,
});

my $header = $csv->getline($fh);
$csv->column_names(@$header);

while(my $row = $csv->getline_hr($fh)){
my $error = $self->{validator}->validate_employee($row);

if($error){
push @{$self->{errors}} , {
row => $row, 
error => $error,
};
next;
}

my $emp = employee->new(%$row);
push @{ $self->{employees}}, $emp;

}
close $fh;

}

sub employees{ @{$_[0]->{employees}} }
sub errors{@{$_[0]->{errors}}}

1;
