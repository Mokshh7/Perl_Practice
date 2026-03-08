#!/usr/bin/env perl
use strict;
use warnings;
use IO::Socket::INET;
use IO::Select;
use Time::HiRes qw(time sleep);

# Use case: Implement non-blocking and asynchronous processing.
#
# This script starts:
# 1) A non-blocking TCP server.
# 2) Two non-blocking clients.
# 3) One event loop (IO::Select) that handles all sockets without threads.
#
# Why this pattern matters:
# - No connection blocks the whole process.
# - One loop can multiplex reads/writes/timers.

my $server = IO::Socket::INET->new(
    LocalAddr => '127.0.0.1',
    LocalPort => 9091,
    Proto     => 'tcp',
    Listen    => 10,
    Reuse     => 1,
) or die "Cannot start server: $!\n";
$server->blocking(0);

my $selector = IO::Select->new($server);
my %outbox;      # Pending outbound data by socket fileno.
my %role_by_fd;  # Identify sockets in logs.

sub create_client {
    my ($name, $msg) = @_;
    my $client = IO::Socket::INET->new(
        PeerAddr => '127.0.0.1',
        PeerPort => 9091,
        Proto    => 'tcp',
    ) or die "Cannot create $name: $!\n";

    # Non-blocking so print/read cannot freeze the loop.
    $client->blocking(0);
    my $fd = fileno($client);
    $role_by_fd{$fd} = $name;
    $selector->add($client);

    # Queue message for async write handling.
    $outbox{$fd} = "$msg\n";
    return $client;
}

my $client_a = create_client('client-A', 'hello from A');
my $client_b = create_client('client-B', 'hello from B');

my $started = time;
while (time - $started < 4) {
    # Wait for read-ready sockets for up to 200ms.
    my @ready = $selector->can_read(0.2);

    for my $sock (@ready) {
        if ($sock == $server) {
            # Accept as many pending clients as possible.
            while (my $conn = $server->accept) {
                $conn->blocking(0);
                my $fd = fileno($conn);
                $role_by_fd{$fd} = "server-conn-$fd";
                $selector->add($conn);
                $outbox{$fd} = "server: connection accepted\n";
            }
            next;
        }

        my $fd = fileno($sock);
        my $buf = '';
        my $n = sysread($sock, $buf, 4096);

        if (defined $n && $n > 0) {
            print "[$role_by_fd{$fd}] read: $buf";

            # Server-side sockets echo back asynchronously.
            if (($role_by_fd{$fd} // '') =~ /^server-conn-/) {
                $outbox{$fd} .= "server-echo: $buf";
            }
        }
        elsif (defined $n && $n == 0) {
            # Peer closed.
            $selector->remove($sock);
            close $sock;
            delete $outbox{$fd};
            delete $role_by_fd{$fd};
        }
        elsif ($!{EWOULDBLOCK} || $!{EAGAIN}) {
            # No data right now; continue loop.
        }
        else {
            warn "Read error on fd=$fd: $!\n";
        }
    }

    # Separate write phase: async and partial-write safe.
    for my $sock ($selector->handles) {
        next if $sock == $server;
        my $fd = fileno($sock);
        next unless defined $outbox{$fd} && length $outbox{$fd};

        my $written = syswrite($sock, $outbox{$fd});
        if (defined $written) {
            substr($outbox{$fd}, 0, $written, '');
        }
        elsif (!($!{EWOULDBLOCK} || $!{EAGAIN})) {
            warn "Write error on fd=$fd: $!\n";
        }
    }

    # Timer-based async work can run here too.
    # Example: poll metrics, flush queues, trigger retries.
}

for my $sock ($selector->handles) {
    close $sock;
}
print "Done: non-blocking async demo completed.\n";
