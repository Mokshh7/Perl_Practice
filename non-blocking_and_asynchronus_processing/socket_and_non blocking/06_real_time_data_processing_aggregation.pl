#!/usr/bin/env perl
use strict;
use warnings;
use Time::HiRes qw(time sleep);

# Use case: Implement real-time data processing and aggregation.
#
# This script simulates a real-time stream of telemetry events and keeps
# rolling aggregates (count/sum/avg/max) by metric.
#
# Pattern shown:
# - Ingest event
# - Update in-memory aggregates immediately
# - Emit periodic snapshots (every 1 second)

my @stream = (
    { metric => 'throughput_mbps', value => 120 },
    { metric => 'throughput_mbps', value => 125 },
    { metric => 'latency_ms',      value => 15  },
    { metric => 'latency_ms',      value => 19  },
    { metric => 'throughput_mbps', value => 140 },
    { metric => 'latency_ms',      value => 22  },
    { metric => 'throughput_mbps', value => 138 },
);

my %agg;
my $next_emit = time + 1;

for my $event (@stream) {
    # Simulated near-real-time arrival.
    sleep 0.25;

    my $m = $event->{metric};
    my $v = $event->{value};

    # Update aggregate state.
    $agg{$m}{count}++;
    $agg{$m}{sum} += $v;
    $agg{$m}{max} = (!defined $agg{$m}{max} || $v > $agg{$m}{max}) ? $v : $agg{$m}{max};

    print "ingest metric=$m value=$v\n";

    # Periodic publish step (like sending to Kafka, Redis, TSDB, etc.)
    if (time >= $next_emit) {
        print_snapshot(\%agg);
        $next_emit = time + 1;
    }
}

# Final snapshot at stream end.
print_snapshot(\%agg);

sub print_snapshot {
    my ($state) = @_;
    print "---- aggregate snapshot ----\n";
    for my $metric (sort keys %$state) {
        my $count = $state->{$metric}{count} || 1;
        my $sum   = $state->{$metric}{sum}   || 0;
        my $max   = $state->{$metric}{max};
        my $avg   = $sum / $count;
        printf "%s count=%d sum=%.2f avg=%.2f max=%.2f\n",
            $metric, $count, $sum, $avg, $max;
    }
}
