#!/usr/bin/env perl
use strict;
use warnings;
use IO::Socket::INET;
use HTTP::Tiny;
use JSON::PP qw(encode_json decode_json);

# Use case: Consume and expose REST/SOAP APIs.
#
# This single script does both sides:
# 1) Exposes tiny local endpoints:
#    - REST: GET /api/kpi -> JSON
#    - SOAP-like: POST /soap -> XML envelope response
# 2) Consumes those endpoints as a client.
#
# Note: SOAP is represented with minimal XML for learning. In production,
# use a full SOAP library and schema validation.

my $pid = fork();
die "fork failed: $!\n" unless defined $pid;

if ($pid == 0) {
    # Child process: API server
    my $server = IO::Socket::INET->new(
        LocalAddr => '127.0.0.1',
        LocalPort => 9093,
        Proto     => 'tcp',
        Listen    => 10,
        Reuse     => 1,
    ) or die "Server start failed: $!\n";

    my $handled = 0;
    while ($handled < 2) {
        my $sock = $server->accept or next;
        my $request = '';
        $sock->recv($request, 8192);

        if ($request =~ m{^GET\s+/api/kpi\s+HTTP/1\.[01]}m) {
            my $json = encode_json({ node => 'RNC-1', availability => 99.95, sessions => 1240 });
            print {$sock} "HTTP/1.1 200 OK\r\nContent-Type: application/json\r\nContent-Length: "
              . length($json) . "\r\n\r\n$json";
        }
        elsif ($request =~ m{^POST\s+/soap\s+HTTP/1\.[01]}m) {
            my $xml = join '',
                '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">',
                '<soap:Body><GetAlarmCountResponse><count>42</count></GetAlarmCountResponse></soap:Body>',
                '</soap:Envelope>';
            print {$sock} "HTTP/1.1 200 OK\r\nContent-Type: text/xml\r\nContent-Length: "
              . length($xml) . "\r\n\r\n$xml";
        }
        else {
            my $msg = "Not Found";
            print {$sock} "HTTP/1.1 404 Not Found\r\nContent-Length: " . length($msg) . "\r\n\r\n$msg";
        }

        close $sock;
        $handled++;
    }

    close $server;
    exit 0;
}

# Parent process: API client
sleep 1; # Give server time to start.
my $http = HTTP::Tiny->new;

# REST consume example.
my $rest_res = $http->get('http://127.0.0.1:9093/api/kpi');
die "REST call failed\n" unless $rest_res->{success};
my $rest_data = decode_json($rest_res->{content});
print "REST data: node=$rest_data->{node}, availability=$rest_data->{availability}, sessions=$rest_data->{sessions}\n";

# SOAP consume example (raw XML over HTTP).
my $soap_request = join '',
    '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">',
    '<soap:Body><GetAlarmCount/></soap:Body>',
    '</soap:Envelope>';

my $soap_res = $http->post(
    'http://127.0.0.1:9093/soap',
    {
        headers => { 'Content-Type' => 'text/xml' },
        content => $soap_request,
    }
);
die "SOAP call failed\n" unless $soap_res->{success};

my ($count) = $soap_res->{content} =~ m{<count>(\d+)</count>};
print "SOAP data: alarm_count=$count\n";

waitpid($pid, 0);
