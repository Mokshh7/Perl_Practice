#!/usr/bin/env perl
use strict;
use warnings;
use JSON::PP qw(encode_json decode_json);

# Use case: Handle file formats: CSV, JSON, XML, binary logs.
#
# This script writes and reads each format to show typical operations.
# The examples stay dependency-light and intentionally easy to inspect.

my @events = (
    { ts => 1710000001, node => 'ENB-1', metric => 'latency_ms', value => 12 },
    { ts => 1710000002, node => 'ENB-2', metric => 'latency_ms', value => 39 },
    { ts => 1710000003, node => 'ENB-1', metric => 'drop_rate',  value => 2  },
);

# ---------------- CSV ----------------
my $csv_file = 'events.csv';
open my $csv_w, '>', $csv_file or die "Cannot write CSV: $!\n";
print {$csv_w} "ts,node,metric,value\n";
for my $e (@events) {
    # Simple CSV safe enough for this data shape.
    print {$csv_w} join(',', map { $e->{$_} } qw(ts node metric value)) . "\n";
}
close $csv_w;

open my $csv_r, '<', $csv_file or die "Cannot read CSV: $!\n";
<$csv_r>; # skip header
while (my $line = <$csv_r>) {
    chomp $line;
    my ($ts, $node, $metric, $value) = split /,/, $line, 4;
    print "CSV -> ts=$ts node=$node metric=$metric value=$value\n";
}
close $csv_r;

# ---------------- JSON ----------------
my $json_file = 'events.json';
open my $json_w, '>', $json_file or die "Cannot write JSON: $!\n";
print {$json_w} encode_json(\@events);
close $json_w;

open my $json_r, '<', $json_file or die "Cannot read JSON: $!\n";
local $/;
my $json_text = <$json_r>;
close $json_r;

my $decoded = decode_json($json_text);
for my $e (@$decoded) {
    print "JSON -> $e->{node} $e->{metric}=$e->{value}\n";
}

# ---------------- XML ----------------
# Minimal hand-built XML to keep dependencies optional.
my $xml_file = 'events.xml';
open my $xml_w, '>', $xml_file or die "Cannot write XML: $!\n";
print {$xml_w} "<events>\n";
for my $e (@events) {
    print {$xml_w} "  <event ts=\"$e->{ts}\" node=\"$e->{node}\" metric=\"$e->{metric}\" value=\"$e->{value}\"/>\n";
}
print {$xml_w} "</events>\n";
close $xml_w;

open my $xml_r, '<', $xml_file or die "Cannot read XML: $!\n";
while (my $line = <$xml_r>) {
    if ($line =~ /<event\s+ts="(\d+)"\s+node="([^"]+)"\s+metric="([^"]+)"\s+value="(\d+)"\s*\/>/) {
        print "XML -> ts=$1 node=$2 metric=$3 value=$4\n";
    }
}
close $xml_r;

# ---------------- Binary log ----------------
# Store records in fixed binary format for compact logging.
# Format: unsigned32 timestamp + unsigned16 value
my $bin_file = 'events.bin';
open my $bin_w, '>:raw', $bin_file or die "Cannot write binary: $!\n";
for my $e (@events) {
    print {$bin_w} pack('Nn', $e->{ts}, $e->{value});
}
close $bin_w;

open my $bin_r, '<:raw', $bin_file or die "Cannot read binary: $!\n";
while (read($bin_r, my $buf, 6) == 6) {
    my ($ts, $value) = unpack('Nn', $buf);
    print "BIN -> ts=$ts value=$value\n";
}
close $bin_r;
