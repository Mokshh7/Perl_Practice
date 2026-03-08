use strict;
use warnings;
use feature 'say';

use LWP::UserAgent;
use JSON;

my $url = "http://localhost:8080/status";

my $ua = LWP::UserAgent->new;

my $response = $ua->get($url);

if($response->is_success){
my $json_text = $response->decoded_content;
my $data = decode_json($json_text);

say "service : " . $data->{service};
say "status : " . $data->{status};
}else{
die "API request failed : " . $response->status_line ;
}



