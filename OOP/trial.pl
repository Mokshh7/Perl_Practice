use strict;
use feature 'say';
use warnings;

package vehicle;

sub objcr{
my ($cname,%attr) = @_;

my $features = {
wheels => $attr{wheels},
colour => $attr{colour}
};

bless $features,$cname;

}

sub show{
my $features = shift;
foreach(keys %$features){
say $features->{$_};
}
}

my $car = vehicle->objcr(
wheels => 4,
colour => "black"
) ;

$car->show();
