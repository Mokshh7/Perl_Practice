use strict;
use warnings;
use feature 'say';

use IO::Socket::INET;
use IO::Select;
use Fcntl qw(F_GETFL F_SETFL O_NONBLOCK);

#creating server socket

my $server = IO::Socket::INET->new(
LocalPort => 5000,
Type => SOCK_STREAM,
Reuse => 1,
Listen => 10
)
or die "cannot create a socket";

#make server non blocking

my $flags = fcntl($server , F_GETFL , 0);
fcntl($server , F_SETFL , $flags | O_NONBLOCK);

my $select = IO::Select->new();
$select->add($server);

say "server started on port 5000";

while (1){
my @ready = $select->can_read(1);

foreach my $fh(@ready){
if ($fh == $server){
my $client = $server->accept();
next unless $client;
my $cflags = ($client, F_GETFL , 0);
fcntl($client, F_SETFL, $cflags | O_NONBLOCK);

$select->add($client);
say "new client connected";
}else{
my $data ;
my $bytes = sysread($fh , $data , 1024);

if ($bytes){
say "recived : $data";
syswrite($fh , "ACK");
}else{
$select->remove($fh);
close($fh);
say "client disconnected";
}
}
}
}
