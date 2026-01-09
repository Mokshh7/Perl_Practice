use strict;
use warnings;
use feature 'say';


my $input;


$input =  <<'EOF';
Error reported by user john.doe@corp.com from 192.168.0.21
Login failure for admin admin_123@company.org at 10.0.5.14
Password reset requested by alice.smith@service.net from IP 172.16.4.9
Multiple failed attempts detected from 203.0.113.45 for user test.user@demo.co
Connection timeout while accessing api@internal.local from 8.8.8.8
EOF



say $input;


$input =~ s/(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})|(\w+\@\w+\.\w+)/
defined $1 ? '[IP_MASKED]' : '[IP_MASKED]'/mgex;
say $input;
