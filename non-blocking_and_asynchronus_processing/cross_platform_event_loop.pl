use strict;
use warnings;
use feature 'say';

use AnyEvent;
use AnyEvent::HTTP;

my $cv = AnyEvent->condvar;

http_get "http://example.com" , sub {
my ($body , $hdr ) = @_ ;
say "Recived response" ;
$cv->send;
};

$cv->recv;
