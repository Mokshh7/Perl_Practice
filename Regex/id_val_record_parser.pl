use strict;
use feature 'say';
use warnings;

my $input = "ID:12;VAL:45;ID:78;VAL:90;";
my @result;
my %hash;
while($input =~/\G(ID|VAL):(\d+);/g){
my ($key,$val) = ($1,$2);
$hash{$key} = $val;
#say pos($input);
#say "yes";
if (exists $hash{ID} && exists $hash{VAL}){

push @result, {%hash};
%hash = ();
}
say pos($input);
}

use Data::Dumper;
say Dumper(\@result);


