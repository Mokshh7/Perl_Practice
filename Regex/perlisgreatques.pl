use strict;
use warnings;
use feature 'say';

my $input = <<EOF;

Perl is powerful.
Perl is GREAT for text processing!
perl, PERL...
EOF
my $count = () = $input =~ /^\S+/mg;
my $chars = $input;
$chars =~ s/\n//g ;
my $lenn = length $chars;
say $input;
say "total non-empty lines : $count";
say "total characters : $lenn";


my $unq = lc $input;
$unq =~ s/[^a-z\s]/ /g;          # cleanup punctuation
my @words = split /\s+/, $unq;

my %seen;
for (my $i = 0; $i < scalar(@words); $i++) {
    next if $words[$i] eq '';
    $seen{$words[$i]} = 1;
}

my $unique_count = scalar keys %seen;

say "unique words: $unique_count";
