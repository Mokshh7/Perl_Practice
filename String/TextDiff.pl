use strict;
use warnings;
use feature 'say';

my $old = "Perl is powerful and fast";
my $new = "Perl is extremely powerful";

my @neww = split/ /,$new;
my @oldd = split/ /,$old;


my %hash;
my %hash2;
foreach(@oldd){

$hash{$_} +=1;

}

foreach(@neww){

$hash2{$_} +=1;

}
my @removed;
my @common;
my @diffrent;
foreach my $e (@neww){
if (exists $hash{$e}){push @common,$e;}
else{push @diffrent,$e;}
}
foreach my $f (@oldd){
if (exists $hash2{$f}){}
else{push @removed,$f;}
}

say "common: " . join ",",@common;
say "added: " . join ",",@diffrent;
say "removed: " . join ",",@removed;
