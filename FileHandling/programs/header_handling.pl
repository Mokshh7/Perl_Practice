
use warnings;
use feature 'say';
use Text::CSV;


open(my $fh,  '<', '../data/input.csv')  
or die $!;

open(my $out, '>>', '../output/output.csv') or die $!;

my $csv = Text::CSV->new({
binary =>1,
auto_diag => 1,
});

my $header = $csv->getline($fh)
or die "$!" . $csv->error_diag();

sub normzlize_header{

my ($h) = @_;
$h =~ s/^\s+|\s+$//g;
$h = lc $h;
$h =~ s/\s+/ /g;
return $h;
}

my @raw_headers = @$header;
my @norm_headers = map{ normzlize_header($_) }@raw_headers;


my @expected = qw(
id name department notes salary
);

my %expected = map {$_ => 1}@expected;
my %seen = map{ $_ => 1 }@norm_headers;



die "Missing required column:" if grep{ !exists $seen{$_} }@expected;
 
$csv->column_names(@norm_headers);
$csv->getline_hr($fh);
$csv->print($out,\@norm_headers);
print $out "\n";


while(my $row = $csv->getline_hr($fh)){

$csv->print($out,[
$row->{id},
$row->{name},
$row->{department},
$row->{notes},
$row->{salary},
]);
print $out "\n";
}
