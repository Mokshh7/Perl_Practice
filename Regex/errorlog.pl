use strict;
use warnings;
use feature 'say';

my $log = <<EOF;
ERROR at line12: missing ;
WARNING at line15: unused variable
EOF


$log =~ s/\b(ERROR|WARNING)\b/ucfirst(lc($1))/eg;
$log =~ s/line(\d+)/line $1/g;
$log =~ s/^(\w+)\s+at\s+line\s+(\d+):\s+(.*)$/. $1 : line $2 - $3 /gm;


say $log;
