use strict;
use warnings;
use feature 'say';
my @arr;
package User;
sub newuser{
my ($cname,%user) = @_;
my $usr_data = {
username => $user{username},
password => $user{password}
};
bless $usr_data,$cname;
}
sub set_acct{
my ($name,$pass) = @_;
say "username";
$name = <STDIN>;
chomp $name;
say "pass:";
$pass = <STDIN>;
chomp $pass;
my $userr = User->newuser(
username => "$name",
password => "$pass"
);
push @arr , $userr;
}
set_acct();


sub login{
my ($name,$pass) = @_;
say "enter username : ";
$name = <STDIN>;
chomp $name;
say "enter password : ";
$pass = <STDIN>;
chomp $pass;
foreach(@arr){
if($_->{username} eq $name && $_->{password} eq  $pass){
say "yes";}}}
login();
