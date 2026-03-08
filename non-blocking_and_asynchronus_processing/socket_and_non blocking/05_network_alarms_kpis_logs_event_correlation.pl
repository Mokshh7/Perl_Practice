#!/usr/bin/env perl
use strict;
use warnings;

# Use case: Work with network alarms, KPIs, logs, and event correlation.
#
# This example simulates NOC-like telemetry and performs:
# 1) KPI calculation (availability and average latency).
# 2) Alarm generation rules.
# 3) Correlation of repeated alarms into one incident.

my @logs = (
    { ts => 1, node => 'RAN-01', latency_ms => 12, packet_loss => 0, up => 1 },
    { ts => 2, node => 'RAN-01', latency_ms => 15, packet_loss => 0, up => 1 },
    { ts => 3, node => 'RAN-01', latency_ms => 210, packet_loss => 9, up => 1 },
    { ts => 4, node => 'RAN-01', latency_ms => 230, packet_loss => 11, up => 1 },
    { ts => 5, node => 'RAN-01', latency_ms => 18, packet_loss => 0, up => 1 },
    { ts => 6, node => 'RAN-01', latency_ms => 19, packet_loss => 0, up => 0 },
    { ts => 7, node => 'RAN-01', latency_ms => 17, packet_loss => 0, up => 1 },
);

# KPI computation.
my $samples = scalar @logs;
my $up_count = 0;
my $latency_sum = 0;
for my $row (@logs) {
    $up_count++ if $row->{up};
    $latency_sum += $row->{latency_ms};
}

my $availability = ($up_count / $samples) * 100;
my $avg_latency  = $latency_sum / $samples;
printf "KPI: availability=%.2f%% avg_latency=%.2fms\n", $availability, $avg_latency;

# Alarm rules (tune thresholds to your network policy).
my @alarms;
for my $row (@logs) {
    if ($row->{up} == 0) {
        push @alarms, { ts => $row->{ts}, node => $row->{node}, type => 'NODE_DOWN', severity => 'CRITICAL' };
    }
    if ($row->{latency_ms} > 200 && $row->{packet_loss} > 5) {
        push @alarms, { ts => $row->{ts}, node => $row->{node}, type => 'CONGESTION', severity => 'MAJOR' };
    }
}

# Event correlation:
# Merge nearby congestion alarms into a single incident window.
my @incidents;
my $active;
for my $a (@alarms) {
    if ($a->{type} eq 'CONGESTION') {
        if (!$active) {
            $active = {
                node => $a->{node},
                type => 'CONGESTION_INCIDENT',
                start_ts => $a->{ts},
                end_ts   => $a->{ts},
                count    => 1,
            };
        }
        elsif ($a->{ts} - $active->{end_ts} <= 2) {
            $active->{end_ts} = $a->{ts};
            $active->{count}++;
        }
        else {
            push @incidents, $active;
            $active = {
                node => $a->{node},
                type => 'CONGESTION_INCIDENT',
                start_ts => $a->{ts},
                end_ts   => $a->{ts},
                count    => 1,
            };
        }
    }
    else {
        # Non-correlated alarms can be stored directly as incidents.
        push @incidents, {
            node => $a->{node},
            type => $a->{type},
            start_ts => $a->{ts},
            end_ts   => $a->{ts},
            count    => 1,
        };
    }
}
push @incidents, $active if $active;

print "Alarms generated:\n";
for my $a (@alarms) {
    print "  ts=$a->{ts} node=$a->{node} type=$a->{type} severity=$a->{severity}\n";
}

print "Correlated incidents:\n";
for my $i (@incidents) {
    print "  node=$i->{node} type=$i->{type} window=$i->{start_ts}-$i->{end_ts} count=$i->{count}\n";
}
