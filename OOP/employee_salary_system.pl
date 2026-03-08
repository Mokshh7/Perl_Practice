use warnings;
use strict;
use feature 'say';

package Employee;

sub new{
my ($ename,%info) = @_;

my $e_info = {
emp_id => $info{emp_id},
name => $info{name},
basic_sal => $info{basic_sal}
};

bless $e_info,$ename;

}

sub calc_sal{

my ($ename) = @_;

my $HRA = $ename->{basic_sal} / 20;
my $DA = $ename->{basic_sal} / 10;
return $ename->{basic_sal} + $HRA + $DA ;
}

my $e1 = Employee->new(
emp_id => 1,
name => "Alice",
basic_sal => 10000000
);

my $sal = calc_sal($e1);
say $sal;
