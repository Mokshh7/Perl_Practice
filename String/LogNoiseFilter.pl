use strict;
use feature 'say';
use warnings;

my $log = <<EOF;
ERROR: Connection failed
ERROR: Connection failed
ERROR: Connection failed
INFO: Retrying
INFO: Retrying
WARN: Low memory
ERROR: Connection failed
ERROR: Connection failed
INFO: Done
EOF


my @logs = split /\n/,$log;
my $counter = 0;
my $last = "";
foreach my $l (@logs){
if ($l eq $last){$counter++;}
else{

if ($counter > 1){say "$last(repeated $counter times)";}elsif($counter == 1){say $last;}
$last = $l;
$counter = 1;

}


}
