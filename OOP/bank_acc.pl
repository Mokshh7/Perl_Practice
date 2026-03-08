use strict;
use warnings;
use feature 'say';

package bank;

sub new{

my ($bankname , %account_details) = @_;
my $acc_info = {
account_no => $account_details{account_no},
balance => $account_details{balance}
};

bless $acc_info , $bankname;

}


sub deposit{
my ($dep_to,$amt) = @_;
$dep_to->{balance}+= $amt;
#say $dep_to->{balance};
}


sub withdraw{
my ($wd_from,$amt) = @_;
$wd_from->{balance} = $wd_from->{balance} - $amt;
#say $wd_from->{balance};
}

sub getbalance{
my ($balance_info) = shift;
say "Total balance : $balance_info->{balance}";
}

my $p = bank->new(account_no => 123123123,balance => 10000000);
$p->withdraw(100);
$p->deposit(10000);
$p->getbalance();
