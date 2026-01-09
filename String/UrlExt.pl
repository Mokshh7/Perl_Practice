use strict;
use warnings;
use feature 'say';
my $url = "https://example.com/products/item1";
my $nosl = $url;
$nosl =~ s/\///g;

my $sch = $url;

if ($sch =~ m{^(https?://[^/]+)(/.*)?$}) {
say "scheme $1";
say "base  $2";

}


say $nosl;
say $sch;
