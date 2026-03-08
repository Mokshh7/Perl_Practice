use strict;
use warnings;
use feature 'say';

use IO::Socket::INET;
use IO::Select;

my $server = IO::Socket::INET->new(
    LocalAddr => '127.0.0.1',
    LocalPort => 5000,
    Proto     => 'tcp',
    Listen    => 5,
    Reuse     => 1,
) or die "Socket failed: $!";

my $select = IO::Select->new($server);

while(1){
foreach my $fh ($select->can_read(1)){
if($fh == $server){
my $new = $server->accept();
$select->add($new);
}else{
my $data ;
$fh->recv($data,1024);


if($data){
say "recived : $data";
}
else {
$select->remove($fh);
close $fh;
}
}
}
}
