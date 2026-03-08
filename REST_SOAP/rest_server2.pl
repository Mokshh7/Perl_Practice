use strict;
use warnings;
use feature 'say';

use HTTP::Daemon;
use HTTP::Status;
use HTTP::Response;

use JSON;

my $daemon = HTTP::Daemon->new(
LocalPort => 8080,
Reuse =>1
) or die 
"cannot start server : $!";


say "server running at " , $daemon->url();

while( my $client = $daemon->accept){

while(my $request = $client->get_request){

say "request : " . $request->method . " " . $request->uri; 

if ($request->method eq 'GET' && $request->uri->path eq "/status"){

my $response_data = {
service => "Telemetry API",
status => "running"
};

my $json = encode_json($response_data);

my $response = HTTP::Response->new(200);
$response->header('Content-Type' => 'application/json');
$response->header('Content-Length' => length($json));
$response->content($json);
$client->send_response($response);
}else{
$client->send_error(RC_NOT_FOUND);
}
}

$client->close;
}
