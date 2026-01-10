use strict ;
use warnings ;
use feature 'say';
my $text = "Perl";
if ($text !~ /perl/)
{say "perl";}

my @words( perl perlx xperl);

foreach (@words){

say "$_ => ";
print "MATCH\n" if /^perl$/;

}
