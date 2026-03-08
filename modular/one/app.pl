#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';


use FindBin;
use lib "$FindBin::Bin/lib";

use EmployeeStore;
 
my $store = EmployeeStore->new;


$store->load_from_csv("$FindBin::Bin/data/employees.csv");

say "=== VALID EMPLOYEES ===";
for my $emp ($store->employees) {
    say join " | ",
        $emp->employee_id,
        $emp->name,
        $emp->department,
        $emp->salary,
        $emp->status;
}

say "\n=== INVALID RECORDS ===";
for my $err ($store->errors) {
    say "Error: $err->{error}";
}

