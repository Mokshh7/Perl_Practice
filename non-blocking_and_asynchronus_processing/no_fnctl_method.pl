use strict;
use warnings;
use feature 'say';
use Socket;
use IO::Socket::INET;
use IO::Select;

my $server = IO::Socket::INET->new(
LocalPort => 5000,
 LocalAddr => '127.0.0.1',
Type => SOCK_STREAM,
Proto => 'tcp',
Reuse => 1,
Listen => 10,
) or die $!;

my $select = IO::Select->new($server);

while(1){
for my $fh ($select->can_read(1)){

if($fh == $server){
my $client = $server->accept();
$select->add($client) if $client;
}else{
my $data;
my $bytes = sysread($fh , $data , 1024);
if($bytes){
syswrite($fh , "ACK");
}else{
$select->remove($fh);
close $fh;
}

}
}
}
