use strict;
use warnings;
use feature 'say';

my $text = <<"EOF";

	This   is   a    sample     paragraph.

It contains		tabs,   multiple     spaces,   

and empty lines.     


EOF

my $count = 0;


$count += ($text =~ s/\t/ /g);


$count += ($text =~ s/ {2,}/ /g);


 $count += ($text =~ s/^[ ]+//gm);

$count += ($text =~ s/[ ]+$//gm);
$count += ($text =~ s/^\n+//gm);

say "Normalized Text:\n$text";
say "Whitespace substitutions performed: $count";
