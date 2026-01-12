use strict;
use warnings;
use feature 'say';

sub gvref{

my ( $sendref ) = @_;
my @arr = @{$sendref};
for(my $i = @arr - 1 ; $i >= 0 ; $i--){

say "$sendref->[$i]";

}


}
my $array = [10,20,30];
gvref($array);
