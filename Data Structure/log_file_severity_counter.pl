use strict;
use feature 'say';
use warnings;

my $input = <<EOF;
INFO Application started
WARN Low disk space
INFO User logged in
ERROR Database connection failed
WARN Memory usage high
ERROR Timeout occurred
EOF

my %hash;

my @array = $input =~ m/^(ERROR|INFO|WARN)/mg;
#say @array;

foreach (@array){

if($_ eq "ERROR"){
$hash{ERROR} += 1;
}elsif($_ eq "INFO"){
$hash{INFO} += 1;
}else{
$hash{WARNING} += 1;

}
}
 
use Data::Dumper;
say Dumper(%hash);
