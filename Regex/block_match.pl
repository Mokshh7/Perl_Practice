use strict;
use warnings;
use feature 'say';

my $input = <<EOF;
START
data1
data2
END
EOF

if($input =~ /START.*END/s){
say "yes";
}
