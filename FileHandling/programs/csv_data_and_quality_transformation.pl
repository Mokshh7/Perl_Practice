use strict;
use warnings;
use feature 'say';
use Text::CSV;
use Data::Dumper;
use Scalar::Util qw(looks_like_number);

my @array;
my $hash_ref;

open(my $fh, "<" , "../data/Messy_Employee_dataset.csv")
or die $!;

open(my $fhh, ">" , "../output/raw_input.csv")
or die $!;

my $csv = Text::CSV->new({ binary => 1, sep_char => ",", auto_diag => 1 });

my $reading_files = $csv->getline($fh);
$csv->column_names(@$reading_files);

my $rowno = 0;

while (my $row = $csv->getline($fh)) {

my $hash_ref = {};

for (my $i = 0; $i < @$reading_files; $i++) {
    $hash_ref->{ $reading_files->[$i] } = $row->[$i];
}

push @array, $hash_ref;
$rowno++;


}

$csv->eof or $csv->error_diag();

my @invalid_rows;
my @valid_rows;

my %SCHEMA = (
Employee_ID => 1,
First_Name => 1,
Last_Name => 1,
Department_Region => 1,
Status => 1,
Email => 1,

Age               => 1,
Join_Date         => 0,
Salary            => 0,
Phone             => 0,
Performance_Score => 0,
Remote_Work       => 0,


);

foreach my $hh (@array) {

my $is_invalid = 0;

foreach my $field (keys %SCHEMA) {

if($SCHEMA{$field}) {
if(
 !exists $hh->{$field}
|| !defined $hh->{$field}
|| $hh->{$field} =~ /^\s*$/
){
$is_invalid = 1;
last;
}
}
}

if ($is_invalid ){
    push @invalid_rows, $hh;
} else {
    push @valid_rows, $hh;
}


}

foreach my $bad (@invalid_rows) {
    foreach my $key (sort keys %{$bad}) {
        my $value = defined $bad->{$key} ? $bad->{$key} : '[MISSING]';
        say $fhh "$key => $value";
    }
    say $fhh "";
}

my $len_inv = @invalid_rows;
my $valid_r = @valid_rows;

say $len_inv;
say $valid_r;

foreach my $val(@valid_rows){

if(!$val->{Employee_ID} =~/\w{7}/){
say "yes";
}

if(!$val->{Email} =~/\w\@\w+\.\w+/){
my $x = $val;
push(@invalid_rows,$x);
@valid_rows = grep{$_ ne $val}@valid_rows;
}
if(!$val->{age} =~/[1-7][0-9]/){
say "yes";
}
if(!val =~ sla)
}

open(my $fhhh, ">>" , "../output/clean_data")

    or die "Cannot open clean_data: $!";
foreach my $dab (@valid_rows) {
foreach my $key (sort keys %{$dab}) {
say $fhhh "$key => $dab->{$key}";
}
say $fhhh "";
}

foreach my $dabb (@invalid_rows) {
    foreach my $key (sort keys %{$dabb}) {
        my $value = defined $dabb->{$key} ? $dabb->{$key} : '[MISSING]';
        say $fhh "$key => $value";
    }
    say $fhh "";
}
