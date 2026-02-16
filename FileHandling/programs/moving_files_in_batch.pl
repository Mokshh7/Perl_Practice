use strict;
use warnings;
use feature 'say';
use File::Copy qw(move);
use File::Path qw(make_path);

my $dest = "../archive";

make_path($dest);

for my $file(glob "*.csv"){
move $file , "$dest/$file"
or warn "move failed : $!";
}
