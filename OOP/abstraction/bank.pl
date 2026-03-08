use strict;
use warnings;
use feature 'say';

# Abstracted Class

package BankAccount;

sub new {
my ($class , $initial_balance) = @_;

my $self = {
_balance => $initial_balance || 0
};
bless $self,$class;
return $self;
}
#public method 
sub deposit{
my ($self , $amount) = @_;
$self->_validate_amount($amount);
$self->{_balance} += $amount;
}

#public method
sub withdraw{
my ($self , $amount) = @_;
$self->_validate_amount($amount);
die "Insufficient funds" if $amount > $self->{_balance};

$self->{_balance} -= $amount;
}
#public method
sub get_balance {
my ($self) = @_;
return $self->{_balance};
}

#private method
sub _validate_amount {
my ($self, $amount) = @_;
die "Invalid amount\n" unless $amount > 0;
}
1;

package main;

my $account = BankAccount->new(1000);

$account->deposit(500);
$account->withdraw(200);

say "Balance: " . $account->get_balance();
