package CDR::Validator;

use strict;
use warnings;
use feature 'say';

my $E164_REGEX = qr/^\+[1-9]\d{1,14}$/;

sub new{
my ($class) = @_;

return bless {} , $class;
}

sub validate{

my ($self,$cdr_hash) = @_;

return {
valid => 0,
reason => "invalid input structure"
} unless $cdr_hash && ref $cdr_hash eq 'HASH';

#mandatory fields 
for my $field (qw(caller callee start_time duration call_type)){
unless(defined $cdr_hash->{$field} && $cdr_hash->{$field} ne ''){
return {
valid => 0 ,
reason => "Missing mandatory field : $field"
};
}
}

# E.164 Validation 

unless ($cdr_hash->{caller} =~ $E164_REGEX){
return {
valid => 0,
reason => "Invalid E.164 format for caller",
};
}


unless($cdr_hash->{callee} =~ $E164_REGEX){
return {
valid => 0 ,
reason => "Invalid E.164 format for callee"
};
}

# call type validation

unless($cdr_hash->{call_type} eq 'VOICE' || $cdr_hash->{call_type} eq 'SMS'){
return{
valid => 0,
reason => "Invalid call type"
};
}

#duration rules 

unless ($cdr_hash->{duration} =~ /^\d+$/){
return {
valid => 0,
reason => "invalid duration format"
};
}

#voice calls must be > 0

if ($cdr_hash->{call_type} eq 'VOICE' && $cdr_hash->{duration} == 0){
return{
valid => 0 ,
reason => "non billable VOICE call (0 duration)"
};
}
 
return {
valid => 1
};

}

1;
