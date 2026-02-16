use strict;
use warnings;
use feature 'say';
use Getopt::Long;

my ($uppercase , $lowercase , $line_numbers , $outfile);

GetOptions(
'uppercase' => \$uppercase,
'lowercase' => \$lowercase,
'line-numbers' => \$line_numbers,
'out=s' => \$outfile,

) or exit ;

if ($uppercase && $lowercase){

warn "--uppercase and --lowercase cant be used together\n";
exit ;
}


my $in_fh;

if(@ARGV){
open $in_fh , "<" , $ARGV[0] or do {
warn "cannot open input file $ARGV[0] : $!";
exit ; };
}else{
$in_fh = *STDIN;
}

my $out_fh;

if($outfile){
    open $out_fh, '>', $outfile
        or do {
            warn "Cannot open output file '$outfile': $!\n";
            exit ;
        };
}else{
$out_fh = *STDOUT;
}
my $line_no = 0;

while (my $line = readline $in_fh){

$line_no++;

chomp $line;

$line = uc $line if $uppercase;
$line = lc $line if $uppercase;

if($line_numbers){
$line = "$line_no : $line";

}
say $out_fh "$line"
or exit;
}


exit ;
