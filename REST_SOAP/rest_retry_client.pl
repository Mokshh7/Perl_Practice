use strict;
use warnings;
use feature 'say';

use LWP::UserAgent;
use Time::HiRes qw(sleep);

my $url = "https://httpbin.org/status/500";

my $ua = LWP::UserAgent->new(timeout => 5);

my $max_retries = 5;
my $attempt = 0;

while($attempt < $max_retries){

$attempt++;
say "Attempt $attempt";

my $response = $ua->get($url);

if($response->is_success){
say "Success ";
last
}

say "Failed : " . $response->status_line . "";

my $backoff = 2 ** $attempt;
say "Retrying in $backoff seconds...";
sleep($backoff);
}
