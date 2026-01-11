use strict;
use feature 'say';
use warnings;


my $config = {
db => {
host => "localhost",
port => 5432
}
};

sub aa{
my ($host) = @_;

foreach (keys %{$config}){

say $config->{$_}->{$host};

}}

aa("host");
