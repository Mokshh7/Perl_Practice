use strict;
use warnings;
use feature 'say';
 
my $csv = "10,20,47,11";
my @spli = split /,/ ,$csv;
my @values;
@values = map{ int($_)}@spli;

my $sum = 0 ;
my $max  = undef;

#@values = map{ $_ + 0 }@values;

#
#my $sum = 0;
#map{$sum+=$_ }@values;
#my $sc = @values;
#my $mean = $sum / $sc;
#say $mean; 

my $has_list = eval {

require List::Util;
List::Util (qw(sum max));
1;
};

if ($has_list){

 $sum = List::Util::sum(@values);
 $max = List::Util::max(@values);
}else{
foreach my $v (@values){
$sum += $v;

$max = $v if !defined($max) || $v > $max;
}

}

my $mean =$sum / scalar (@values);
say $mean;
say $max;
