package App;
use strict;
use warnings;
use feature 'say';
use parent qw(Logger Serializer);

sub new {
    bless {}, shift;
}

1;
