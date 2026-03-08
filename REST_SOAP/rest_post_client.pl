use strict;
use warnings;
use feature 'say';

use LWP::UserAgent;
use HTTP::Request;

use JSON;

my $url = "https://httpbin.org/post";

my $data = {
    device_id  => "router-01",
    cpu_useage => 72,
    memory     => 65,
};

my $json_payload = encode_json($data);

my $ua = LWP::UserAgent->new();

my $request = HTTP::Request->new(POST => $url);
$request->header('content-type' => 'application/json');
$request->content($json_payload);

my $response = $ua->request($request);

if ($response->is_success) {

say "Response : ";
say $response->decoded_content;

} else {
    die "POST failed : " . $response->status_line;

}
