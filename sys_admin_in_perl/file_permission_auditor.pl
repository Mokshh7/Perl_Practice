use strict;
use warnings;
use feature 'say';


chdir 'sysadddt' or die "no such file $!";

my $dir = '/home/lab/perl/sys_admin_in_perl/sysadddt';

opendir my $dirrr , $dir or die "$!";

my @output = readdir($dirrr);

foreach(@output){
if($_ =~ /.sh$/){
chmod 0755,$_
or warn "failed to change for $_" ;
}else{next;}
}

