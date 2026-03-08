#!/usr/bin/env perl
use strict;
use warnings;
use IO::Select;
use IO::Socket::INET;
use Time::HiRes qw(time);

# Use case: Optimize I/O, file handling, and network communication.
#
# Demonstrates three practical optimizations:
# 1) Buffered file reads in chunks instead of line-by-line overhead.
# 2) Non-blocking socket writes with backpressure handling.
# 3) Lightweight instrumentation to measure throughput.

my $input_file  = 'optimized_input.log';
my $output_file = 'optimized_output.log';

# Create synthetic input only once for reproducible demo.
unless (-e $input_file) {
    open my $seed, '>', $input_file or die "Cannot create $input_file: $!\n";
    for my $i (1 .. 20_000) {
        print {$seed} "event=$i status=ok payload=sample-data-$i\n";
    }
    close $seed;
}

# Fast chunked copy/transform.
my $t0 = time;
open my $in,  '<', $input_file  or die "Cannot open input: $!\n";
open my $out, '>', $output_file or die "Cannot open output: $!\n";

my $total_bytes = 0;
while (1) {
    my $bytes = read($in, my $chunk, 64 * 1024); # 64KB blocks
    die "Read error: $!\n" if !defined $bytes;
    last if $bytes == 0;

    # Cheap transform: uppercase status values.
    $chunk =~ s/status=ok/status=OK/g;

    print {$out} $chunk or die "Write error: $!\n";
    $total_bytes += $bytes;
}
close $in;
close $out;

my $file_elapsed = time - $t0;
printf "File optimization: %d bytes processed in %.3f sec\n", $total_bytes, $file_elapsed;

# Network optimization demo:
# - Local loopback server to receive data.
# - Client sends in non-blocking mode with partial-write handling.
my $server = IO::Socket::INET->new(
    LocalAddr => '127.0.0.1',
    LocalPort => 9092,
    Proto     => 'tcp',
    Listen    => 5,
    Reuse     => 1,
) or die "Cannot start network sink: $!\n";

my $client = IO::Socket::INET->new(
    PeerAddr => '127.0.0.1',
    PeerPort => 9092,
    Proto    => 'tcp',
) or die "Cannot connect to sink: $!\n";
$client->blocking(0);

my $conn = $server->accept or die "Accept failed: $!\n";
$conn->blocking(0);

my $payload = ('X' x 200_000) . "\n";
my $sel = IO::Select->new($client);

my $sent = 0;
my $recv = 0;
my $net_t0 = time;

while ($recv < length($payload)) {
    # Send as much as possible without blocking.
    if ($sent < length($payload)) {
        my $n = syswrite($client, substr($payload, $sent), 32 * 1024);
        if (defined $n) {
            $sent += $n;
        }
        elsif (!($!{EWOULDBLOCK} || $!{EAGAIN})) {
            die "Client write error: $!\n";
        }
    }

    # Read sink side.
    my $r = sysread($conn, my $buf, 32 * 1024);
    if (defined $r && $r > 0) {
        $recv += $r;
    }
    elsif (defined $r && $r == 0) {
        last;
    }
    elsif (!($!{EWOULDBLOCK} || $!{EAGAIN})) {
        die "Server read error: $!\n";
    }
}

my $net_elapsed = time - $net_t0;
printf "Network optimization: sent=%d recv=%d bytes in %.3f sec\n", $sent, $recv, $net_elapsed;

close $client;
close $conn;
close $server;
