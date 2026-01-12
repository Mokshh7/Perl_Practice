use strict;
use warnings;
use feature 'say';


my $dept = {IT => ["Alice", "Bob"]};

push (@{$dept->{IT}},"Charlie");

#say join $dept->{IT};
say join "," , @{$dept->{IT}};
