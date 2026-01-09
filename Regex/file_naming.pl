use warnings;
use strict;
use feature 'say';

sub fname{
 
my $file = $_;

$file = lc $file;
$file =~ s/^(.*?)(.?)(\.[^.]+)?$/
do {
my ($name,$ext) = ($1,$2 // '');
$name =~ s/\s+/_/g;

$name =~ s/[^a-z0-9._-]+//g;
$name =~ s/_+/_/g;

$name =~ s/^_+|_+$//g;

"$name$ext"
}
/e
return filename;
}

my $input = "  yeahhh reporttt . txt";
my $output = fname($input);
say "$output";
