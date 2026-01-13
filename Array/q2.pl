use strict;
use warnings;
use feature 'say';


my $input = "i am a student.";

my @arr = $input =~ m/(\w+|\.)/g;
my @arrayy;
say join ",",@arr;

foreach (@arr){

#if(length($_) > 1 ){
my @str;
for (my $i = length($_) ; $i >= 0  ;$i-- ){

push(@str,substr($_,$i,1));
#say @str;
#}
}

#print join ",",@str ;
}


print "\n";

say @arrayy;
