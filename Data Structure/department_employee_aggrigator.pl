use strict;
use warnings;
use feature 'say';

my @arr = (["IT","Alex"], ["HR","Riya"], ["IT","John"]);
my %hash;
my $a;
foreach my $pair(@arr){

my($dept,$emp) = @{$pair};
push @{$hash{$dept}},$emp;
} 


foreach my $key (keys %hash){ say "$key => @{$hash{$key}}";}
