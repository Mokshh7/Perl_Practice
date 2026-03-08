use strict;
use warnings;
use IO::Select;
use IO::Socket::INET;

my $server = IO::Socket::INET->new(
    LocalPort => 5000,
    Listen    => 5,
    Reuse     => 1
) or die $!;

my $selector = IO::Select->new($server);

while(1){
my @ready = $selector->can_read(1);

for my $fh(@ready){
if($fh == $server){
my $client = $server->accept();

}
}
}
 
