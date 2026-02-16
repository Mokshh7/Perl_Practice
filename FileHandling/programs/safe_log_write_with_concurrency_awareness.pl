use strict;
use warnings;
use feature 'say';
use Fcntl qw(:flock);

my $reset = (@ARGV && @ARGV[0] eq '--reset');
open(my $fh ,$reset ?  ">" : ">>", "../output/Safe_Log_Writer_with_Concurrency_Awareness.txt")
or die;

flock($fh,LOCK_EX) or die;
#my $line ;
while(defined (my $line = <STDIN>)){
chomp($line);
last if $line eq "0" || $line eq "" ;
my $localtime = localtime();

say $fh "$line : at $localtime PID: $$";


}

flock($fh, LOCK_UN) or die;


close ($fh);
