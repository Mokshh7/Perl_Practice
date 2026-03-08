use strict;
use warnings;
use feature 'say';

use LWP::UserAgent;
use JSON;

my $url = "https://jsonplaceholder.typicode.com/posts/1";

my $ua = LWP::UserAgent->new(
timeout => 10 ,
);
my $response = $ua->get($url);

if ($response->is_success){

my $json = decode_json($response->decoded_content);

say "Title : $json->{title}";
say "Body : $json->{body}";
}else{
die "Request failed : " . $response->status_line;
}
1
