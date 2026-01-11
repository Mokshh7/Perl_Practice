use strict;
use warnings;
use feature 'say';



my $text = "great service great product"; 
my $n    = 2;                               

my @textt = split / /,$text;
my %hash;
foreach(@textt) {

if(exists($hash{$_})){
$hash{$_} += 1;
}else { $hash{$_} += 1; }

}


foreach my $keys(sort keys %hash){
#$hash{$keys};
say " $keys => $hash{$keys}";
}

