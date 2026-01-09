use strict;
use warnings;
use feature 'say';


my $log = <<EOF;
ERROR at line12: missing ;
WARNING at line15: unused variable
EOF


$log =~ s/^(ERROR|WARNING)\s+at\s+line(\d+):\s*(.+)$/• $1 : line $2 : $3/mg;

say $log;
