use strict;
use warnings;
use feature 'say';


sub acc{

my ($name,$dept) = @_;
chomp($name);
chomp($dept);
$name =~ s/\n\t//g;
$dept =~ s/\n\t//g;
$name = ucfirst($name);
say "Welcome $name to the $dept department!"


}
say "Enter your name";
my $name=<STDIN>;
say "Enter your department";
my $dept=<STDIN>;

acc($name,$dept);
