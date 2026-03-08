 use strict;
use warnings;
use feature 'say';

my $sys = `fahhh`;

use IO::Async::Loop;
use IO::Async::Stream;
use IO::Async::Listener;

my $loop = IO::Async::Loop->new;

sub buffer_injestion{
my ($listner , $stream ) =@_;

$stream->configure(
on_read =>sub{
my ($stream , $buffref , $eof) = @_;


            while ($$buffref =~ s/^(.*)\n//) {
                my $line = $1;
                say "received: $line";

                # Echo back
                $stream->write("Echo: $line\n");
            }
return 0;
},
on_closed => sub{
say "client disconnected";
}
);

#add stream to loop
$loop->add($stream);

}
my $listner = IO::Async::Listener->new(
on_stream => \&buffer_injestion,
);

$loop->add($listner);
# bind and listen on localhost : 12345
$listner->listen(
service => 5000,
socktype => 'stream',
on_resolve_error => sub{ die "resolve error : $_[0]"},
on_listen_error => sub{die "listen error : $_[0]"},
);
say "server running on port 5000";

$loop->run;

$sys = `fahhh`;
