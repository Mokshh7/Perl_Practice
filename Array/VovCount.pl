use strict;
use warnings;
use feature 'say';

my @names = ("Moksh","Tavish","Harshit");

my $one = $names[1];
my $subb = substr($one,0,6);
my $nme;

for $nme (@names){
my $count = 0;
for(my $i =0;$i<length($nme);$i++){
my $ch = substr($nme,$i,1);

if ($ch eq "a" || $ch eq "e" || $ch eq "i" || $ch eq "o" || $ch eq "u"){$count++;}

}
say $count;
}




#say $one; 
#say $subb
