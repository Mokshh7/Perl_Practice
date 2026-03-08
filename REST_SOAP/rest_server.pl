use strict;
use warnings;
use feature 'say';

use HTTP::Daemon;
use HTTP::Status;
use HTTP::Response;
use JSON;

my $daemon = HTTP::Daemon->new(
LocalPort => 8080,
Reuse => 1
) or die "cannot start server : $!";

say "Server running at : " , $daemon->url ;

while(my $conn = $daemon->accept){
while (my $request = $conn->get_request){
my $response = HTTP::Response->new(200);
$response->content("Hello from Perl HTTP Server");

$conn->send_response($response);
}
$conn->close;
}
