use strict;
use warnings;
use feature 'say';

use Text::CSV;
use POSIX qw(strftime);


sub random_digits{
my ($length) = @_;
my $digits = '';
for (1 .. $length){
$digits .= int(rand(10));
}
return $digits;
}

sub generate_time{

my $now = time();
my $offset = 86400;
my $timestamp = $now - $offset;
return strftime("%Y-%m-%d %H:%M:%S" , localtime($timestamp) );
}

sub generate_call_type{

my @types = ("VOICE", "SMS" , "DATA");
#DATA = invalid
return $types[int(rand(@types))];

}

sub generate_invalid{
my @invalid_types = (
sub {return '91' . random_digits(10); },
sub{return '+1' . random_digits(15); },
sub{return '+91ABC123456' ; },
);
return $invalid_types[int(rand(@invalid_types))]->();
}

my %countries = (
    IN  => { code => '+91', digits => 10 },
    US  => { code => '+1',  digits => 10 },
    UK  => { code => '+44', digits => 10 },
    DE  => { code => '+49', digits => 11 },
    AU  => { code => '+61', digits => 9  },
    SG  => { code => '+65', digits => 8  },
    AE  => { code => '+971',digits => 9  },
    JP  => { code => '+81', digits => 10 },
);

sub gen_no{
my ($code) = @_;
return $countries{$code}->{code} . random_digits($countries{$code}->{digits});
}

sub generate_number {

    my @types = ('valid', 'invalid');
    my $choice = $types[int(rand(@types))];

    if ($choice eq 'valid') {

        my @country_keys = keys %countries;
        my $rand_country = $country_keys[int(rand(@country_keys))];

        return gen_no($rand_country);
    }
    else {
	return generate_invalid();

      
    }
}

#number of rows to generate
my $rows = 20;

my $csv = Text::CSV->new({
binary => 1,
eol => "\n",
});

my $input_file = "/home/lab/CME/input/cdr_" . strftime("%Y%m%d_%H%M%S",localtime) . ".csv";

open my $fh , ">" , $input_file or die "$!";

#file format : caller,callee,start_time,duration,call_type


$csv->say($fh , ["caller","callee","start_time","duration","call_type"]);

for (1 .. $rows){
my $caller = generate_number();
my $callee = generate_number();

my $start_time = generate_time();
my $duration = int(rand(601)); #0-600 inclusive
my $call_type = generate_call_type();

$csv->say($fh , ["$caller","$callee","$start_time","$duration","$call_type"]);

}

