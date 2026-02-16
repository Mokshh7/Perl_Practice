use strict;
use warnings;
use feature 'say';

my $line = shift or die;
#open my $fh , "<" , $ARGV[0];

my @output = `ls $line`;
use File::Spec;



my $path = "../data/whaa/";

foreach(@output){
chomp $_;


if($_ =~ /.log$/){
system("mkdir -p ../output/whaa/log && mv $line/$_ ../output/whaa/log");
}

if($_ =~ /.csv$/){
system("mkdir -p ../output/whaa/csv && mv $line/$_ ../output/whaa/csv");
}
if($_ =~ /.json$/){
system("mkdir -p ../output/whaa/json && mv $line/$_ ../output/whaa/json");
}

if($_ =~ /.txt$/){
system("mkdir -p ../output/whaa/txt && mv $line/$_ ../output/whaa/txt");
}
}
