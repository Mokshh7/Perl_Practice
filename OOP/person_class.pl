use strict;
use feature 'say';
use warnings;
package person;

sub newperson{
my ($cname,%info) = @_;
my $personal_info = {
name => $info{name},
age => $info{age}
};

bless $personal_info , $cname;

}

sub display{
my $personal_info_display = shift;
foreach(keys %$personal_info_display) {
say "$_ => $personal_info_display->{$_}";
}
}

my $p1 = person->newperson(
name => "Moksh",
age => 21
);

my $p2 = person->newperson(
name => "Rahul",
age => 21
);
my $p3 = person->newperson(
name => "Saket",
age => 21
);
$p1->display();
$p2->display();
$p3->display();
