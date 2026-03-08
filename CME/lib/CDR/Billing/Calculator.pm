package CDR::Billing::Calculator;

use strict;
use warnings;
use feature 'say';

use POSIX qw(ceil);

sub new{
my ($cname , $self ) = @_;

return bless {} , $cname;
}


sub calculate{
my ($self,$cdr_hash) = @_;

my $caller = $cdr_hash->{caller};
my $callee = $cdr_hash->{callee};
my $duration = $cdr_hash->{duration};
my $type = $cdr_hash->{call_type};

if($type eq 'SMS'){

return {
charge => sprintf("%.2f",0.25),
classification => 'SMS'
};
}


#extracting country codes 
sub extract_country_code{
my ($self , $number) = @_;
if ($number =~/^\+(\d{1,3})/){
return $1;
}
return undef ;
}
my $caller_cc = $self->extract_country_code($caller);
my $callee_cc = $self->extract_country_code($callee);

my $classification;
my $rate ;

if($caller_cc == $callee_cc){
$classification = 'LOCAL';
$rate = 0.75;
}else{
$classification = 'INTERNATIONAL';
$rate = 1.50;
}


# converting seconds to billable minutes 

my $minutes = ceil($duration/60);
my $charge = $minutes * $rate;
return {
charge => sprintf("%.2f",$charge),
classifications => $classification
};
}

1;
