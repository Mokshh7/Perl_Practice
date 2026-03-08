#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

use MongoDB;
use BSON::OID;
use Time::HiRes qw(time);
use POSIX qw(strftime);

# ---------------------------
# CONFIG
# ---------------------------

my $ORG_COUNT        = 500;
my $USERS_PER_ORG    = 10;      # 5000 users
my $USAGE_LOGS       = 200_000; # increase to grow DB
my $INVOICES_PER_ORG = 12;

# ---------------------------
# CONNECTION
# ---------------------------

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db     = $client->get_database("cloudsuite");

$db->drop;  # Clean slate

my $org_col   = $db->get_collection("organizations");
my $user_col  = $db->get_collection("users");
my $sub_col   = $db->get_collection("subscriptions");
my $inv_col   = $db->get_collection("invoices");
my $usage_col = $db->get_collection("usage_logs");
my $flag_col  = $db->get_collection("feature_flags");
my $audit_col = $db->get_collection("audit_logs");

# ---------------------------
# HELPERS
# ---------------------------

sub random_choice {
    my @arr = @_;
    return $arr[ rand @arr ];
}

sub random_int {
    my ($min, $max) = @_;
    return int(rand($max - $min + 1)) + $min;
}

sub now_iso {
    return MongoDB::Timestamp->new( time => time(), inc => 1 );
}

# ---------------------------
# GENERATE ORGANIZATIONS
# ---------------------------

say "Generating organizations...";

my @org_ids;

for my $i (1 .. $ORG_COUNT) {
    my $org = {
        name           => "Org_$i",
        domain         => "org$i.com",
        plan           => random_choice(qw(free basic pro enterprise)),
        billing_email  => "finance$i\@org.com",
        status         => "active",
        industry       => random_choice(qw(fintech ecommerce edtech health ai)),
        employee_count => random_int(10, 500),
        created_at     => time(),
        metadata       => {
            region => random_choice(qw(APAC EMEA NA)),
            tier   => random_choice(qw(startup mid-market enterprise))
        }
    };

    my $res = $org_col->insert_one($org);
    push @org_ids, $res->inserted_id;
}

# ---------------------------
# GENERATE USERS
# ---------------------------

say "Generating users...";

my @user_ids;

for my $org_id (@org_ids) {
    for my $u (1 .. $USERS_PER_ORG) {
        my $user = {
            org_id     => $org_id,
            name       => "User_$u",
            email      => "user$u\@" . int(rand(1000)) . ".com",
            role       => random_choice(qw(admin developer analyst viewer)),
            is_active  => 1,
            last_login => time() - random_int(0, 86400 * 30),
            created_at => time(),
            permissions => [
                random_choice(qw(read write manage_users manage_billing))
            ]
        };

        my $res = $user_col->insert_one($user);
        push @user_ids, $res->inserted_id;
    }
}

# ---------------------------
# SUBSCRIPTIONS + INVOICES
# ---------------------------

say "Generating subscriptions and invoices...";

for my $org_id (@org_ids) {

    my $price = random_choice(0, 999, 4999, 19999);

    my $sub_res = $sub_col->insert_one({
        org_id        => $org_id,
        plan          => random_choice(qw(free basic pro enterprise)),
        billing_cycle => "monthly",
        price         => $price,
        currency      => "INR",
        start_date    => time() - 86400 * 365,
        auto_renew    => 1,
        status        => "active",
        version       => random_int(1, 3)
    });

    my $sub_id = $sub_res->inserted_id;

    for my $m (1 .. $INVOICES_PER_ORG) {
        my $amount = $price;
        my $tax    = int($amount * 0.18);
        my $total  = $amount + $tax;

        $inv_col->insert_one({
            org_id          => $org_id,
            subscription_id => $sub_id,
            invoice_number  => "INV-$m-" . int(rand(100000)),
            amount          => $amount,
            tax             => $tax,
            total           => $total,
            status          => random_choice(qw(paid unpaid overdue)),
            issued_at       => time() - (86400 * 30 * $m),
            payment_method  => random_choice(qw(card upi netbanking))
        });
    }
}

# ---------------------------
# FEATURE FLAGS
# ---------------------------

say "Generating feature flags...";

for my $org_id (@org_ids) {
    for my $feature (qw(advanced_reporting ai_insights api_access priority_support)) {
        $flag_col->insert_one({
            org_id            => $org_id,
            feature_name      => $feature,
            enabled           => random_choice(0,1),
            rollout_percentage=> random_int(50,100)
        });
    }
}

# ---------------------------
# USAGE LOGS (HEAVY)
# ---------------------------

say "Generating usage logs (this takes time)...";

for (1 .. $USAGE_LOGS) {

    my $org_id  = random_choice(@org_ids);
    my $user_id = random_choice(@user_ids);

    $usage_col->insert_one({
        org_id      => $org_id,
        user_id     => $user_id,
        feature     => random_choice(qw(api_calls storage compute ai_tokens)),
        units_used  => random_int(1, 1000),
        latency_ms  => random_int(50, 1000),
        request_id  => "req_" . int(rand(1_000_000)),
        timestamp   => time() - random_int(0, 86400 * 90)
    });
}

# ---------------------------
# AUDIT LOGS
# ---------------------------

say "Generating audit logs...";

for (1 .. 20_000) {
    $audit_col->insert_one({
        org_id    => random_choice(@org_ids),
        user_id   => random_choice(@user_ids),
        action    => random_choice(qw(create_user delete_user upgrade_plan login reset_password)),
        timestamp => time(),
        ip        => "192.168." . random_int(0,255) . "." . random_int(0,255)
    });
}

say "Data generation complete.";
