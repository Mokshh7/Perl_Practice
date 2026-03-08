package shape ;
use strict;
use warnings;
use feature 'say';

sub new{
my ($class ,%args) = @_;
return bless \%args,$class;
}


sub area{
die "area() not implimented in base class";
}

sub describe{
return "I am a shape";
}

1;
