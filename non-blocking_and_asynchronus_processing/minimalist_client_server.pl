use strict;
use warnings;
use feature 'say';

use IO::Async::Loop;
use IO::Async::Stream;
use IO::Async::Socket;
use IO::Async::Handle;

#create event loop

my $loop = IO::Async::Loop->new;

#connect to server 

$loop->connect(
host 	=> '127.0.0.1',
service =>  5000,
socktype => 'stream',
on_stream => sub{
my ($stream) = @_ ;

say "connected to server";
say "type messages , ctrl + c to exit";

#handle server responses

$stream->configure(
on_read => sub{
my ($stream , $buffref , $eof) = @_;
while($$buffref =~ s/^(.*)\n//){
say "server : $1" ;
}
return 0;
},
on_closed => sub {
say "server disconnected ";
$loop->stop;
}
);
$loop->add($stream);

#handle stdin (user input)

my $stdin = IO::Async::Stream->new_for_stdin(
on_read => sub{
my ($stdin , $buffref , $eof) = @_; 

while($$buffref =~ s/^(.*)\n//){
my $line = $1;
$stream->write("$line\n");
}
return 0;
}
);
$loop->add($stdin);
},
on_resolve_error => sub{
die "cannot resolve host";
},
on_connect_error => sub{
die "cannot connect to server ";
},

);

#run event loop

$loop->run();
