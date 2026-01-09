use strict;
use warnings;
use feature 'say';

my $filename = <STDIN>;

sub norm{

my ($filename ) = @_;
chomp($filename);
$filename =~ s/[^\w.\s]+//g;
$filename =~ s/\s+/_/g;
$filename =~ s/_+/_/g;
$filename =~ s/_\././g;

say $filename;

}

norm($filename);
