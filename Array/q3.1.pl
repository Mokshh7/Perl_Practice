use strict;
use warnings;
use feature 'say';

my @input = qw(cat dog elephant tiger rat);

my %hash;
foreach (@input){
my @arr ;

my $lenn = length($_);
if (exists $hash{$lenn}){
#$hash{$lenn} = \@arr;
push(@{$hash{$lenn}} ,$_ )
}else{
push(@arr,$_);
$hash{$lenn} = \@arr;
}}

use Data::Dumper;

say Dumper(%hash);

foreach my $key(sort keys %hash){

say "$key => @{$hash{$key}}";

}
