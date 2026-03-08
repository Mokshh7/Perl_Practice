use strict;
use warnings;
use feature 'say';

my $dir = "/tmp/company_log" ; 

chdir "/tmp" or dir "cannot change directory to /tmp: $!";

mkdir "company_logs" unless -d "company_logs";

opendir(my $dh , $dir) or dir "cannot open directory : $!";

my @files = readdir($dh);

close($dh);

say "files in company_logs : ";
foreach my $file(@files){
say "$file " ; 
}

say "Directory setip completed successfully ! ";
