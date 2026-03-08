use strict;
use warnings;
use feature 'say';

use MongoDB;
use Try::Tiny;

my $client = MongoDB->connect("mongodb://localhost:27017");
my $db     = $client->get_database("test");
my $accounts = $db->get_collection("accounts");

my $attempts = 3;

while($attempts > 0){
my $session = $client->start_session;

try{
$session->start_transaction;

$accounts->update_one(
{name => "Moksh"},
{'$inc' => {balance => -100}},
{session => $session }
);

$session->commit_transaction;
say "Transaction committed sucessfully";
last;
}

catch{
say "transaction failed $_";
$session->abort_transaction;
$attempts--;
say "retrying.... attempts left : $attempts";
};
}
