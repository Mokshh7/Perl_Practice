use strict;
use warnings;
use feature 'say';

sub extr{
my ($text , @keywords ) = @_;

my %h ; 

my $regexx = join "|", @keywords;

@h{$text =~ /\b($regexx)\b/ig} = (); 

return keys %h;

}

my $input ="John has experience in Python, Django, and React.";
my @vals = ("python","django");
my @values = extr ($input,@vals);
say @values;
