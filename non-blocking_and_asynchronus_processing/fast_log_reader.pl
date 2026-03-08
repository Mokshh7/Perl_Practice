use strict;
use warnings;
use feature 'say';

use Fcntl qw(:DEFAULT);

my $file = shift or die ""; 

sysopen(my $fh , $file , O_RDONLY) or die ;

my $buffer;
my $chunk_size = 4096;
my $leftover = '';

while(1){
my $bytes_read = sysread($fh , $buffer , $chunk_size);

last unless defined $bytes_read && $bytes_read > 0 ;

$buffer = $leftover . $buffer ;
my @lines = split /\n/ , $buffer;

$leftover = pop @lines;

foreach my $line(@lines){
process_line($line);
}
}

process_line($leftover) if $leftover;

close $fh ;

sub process_line{
my ($line) = @_;
#example processing
say "LINE : $line";  
}
