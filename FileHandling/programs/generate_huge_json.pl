use strict;
use warnings;
use feature 'say';

my $out = "huge_employees.json";
open my $fh, '>', $out or die $!;

say $fh '{';
say $fh '  "metadata": {';
say $fh '    "source": "enterprise_hr_dump",';
say $fh '    "generated_at": "2026-01-27T02:00:00+05:30",';
say $fh '    "record_count": 5000000';
say $fh '  },';
say $fh '  "employees": [';

for my $i (1 .. 5_000_000) {
    print $fh '    {';
    print $fh qq("id":$i,);
    print $fh qq("name":"Employee $i",);
    print $fh qq("department":"Engineering",);
    print $fh qq("salary":75000,);
    print $fh qq("email":'employee$i\\example.com',);
    print $fh qq("active":true);
    print $fh '}';

    print $fh "," if $i < 5_000_000;
    print $fh "\n";
}

say $fh '  ]';
say $fh '}';

close $fh;

say "Generated $out";
