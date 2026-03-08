package CDR::Parser;

use strict;
use warnings;
use feature 'say';

use Text::CSV;

my $csv = Text::CSV->new({
binary => 1,
eol => "\n"
});


sub new{
my ($class) = @_;
return bless {},$class;
}

sub parse_row{

my ($self , $row) = @_;

return undef unless $row && ref $row eq 'ARRAY';
return undef unless @$row == 5;

my ($caller,$callee,$start_time,$duration,$call_type) = @$row;

#basic normalization (trim spaces)

for ($caller,$callee,$start_time,$duration,$call_type){
if(!defined $_){
$_ = '';
}
$_ =~ s/^\s+//;
$_ =~ s/\s+$//;
}
$duration = 0 + ($duration // 0);

return {
caller => $caller,
callee => $callee,
start_time => $start_time,
duration => $duration,
call_type => $call_type,
};

}
1;
