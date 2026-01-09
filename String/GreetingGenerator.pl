use strict;
use warnings;
use feature 'say';
sub  greetings{
my ($name,$dept) = @_ ;
chomp($name,$dept);
$name =~ s/^\s+|\s+$//g;
$dept =~ s/^\s+|\s+$//g;

$dept = ucfirst lc $dept;


  say <<"EMAIL";  
Dear $name,\n
I would like to extend my warmest wishes to you and the entire $dept team for a Merry Christmas and a joyful holiday season.
\n
May this time bring you rest, good health, and continued success. Thank you for your dedication and contributions throughout the year. I look forward to our continued collaboration in the coming year.
\n
Wishing you a peaceful and prosperous New Year.
Kind regards,
$name

EMAIL

}
say "Your name" ;
my $name = <STDIN>;
say "your department" ;
my $dept = <STDIN>;

greetings($name,$dept);
