use strict;
use warnings;
use feature 'say';

for my $file(glob '*'){
next if $file =~ /\.pl$/;
next unless -f $file;

unlink $file or warn "failed to remove $file : $!";

}
