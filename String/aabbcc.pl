use strict;
use warnings;
use feature 'say';

my $str = "aaabbcdddd";

my $char;
my %chars;

for (my $i = 0; $i < length($str); $i++) {
    my $c = substr($str, $i, 1);
    $chars{$c} = 0;
}

my $lenn = keys %chars;

foreach my $char (keys %chars) {
    for (my $j = 0; $j < length($str); $j++) {
        my $char2 = substr($str, $j, 1);
        if ($char eq $char2) {
            $chars{$char}++;
        }
    }
}


foreach my $nn (keys %chars){
print("$nn$chars{$nn}");
}
say "";
