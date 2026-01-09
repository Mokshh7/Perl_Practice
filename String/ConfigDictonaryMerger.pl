use feature 'say';
use warnings;
use strict;

my $input3;
my %hash;
my $input;
sub entries{

do{

say "enter key:";
chomp (my $keyinput = <STDIN>);
$input = $keyinput;
if($keyinput ne "done"){
say"its value";

chomp(my $valueinput = <STDIN>);
$hash{$keyinput} = $valueinput;
}
}while($input ne "done");
for my $a(keys %hash){say "$a => $hash{$a}";} 
}

sub callentries{
say "press enter to start,type done to stop";

do {
chomp(my $input2 = <STDIN>);

$input3 = $input2;
if($input2 ne "done"){
entries();
}
}while($input3 ne "done");


}

callentries();
