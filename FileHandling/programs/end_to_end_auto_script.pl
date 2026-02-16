use strict;
use warnings;
use feature 'say';
use File::Spec;
use Scalar::Util qw(looks_like_number);

sub validate_row {
    my ($row) = @_;
    my @errors;
    # employee_id
    push @errors, "invalid employee_id"
        unless defined $row->{employee_id}
        && $row->{employee_id} =~ /^\d+$/
        && $row->{employee_id} > 0;
    # name
    push @errors, "invalid name"
        unless defined $row->{name}
        && $row->{name} ne ""
        && $row->{name} !~ /^\d+$/;
    # email
    push @errors, "invalid email"
        unless defined $row->{email}
        && $row->{email} =~ /\@/
        && $row->{email} =~ /\./;
    # salary
    push @errors, "invalid salary"
        unless defined $row->{salary}
        && looks_like_number($row->{salary})
        && $row->{salary} > 0;
    # join_date
    push @errors, "invalid join_date"
        unless defined $row->{join_date}
        && $row->{join_date} =~ /^\d{4}-\d{2}-\d{2}$/;
    # status
    push @errors, "invalid status"
        unless defined $row->{status}
        && (lc($row->{status}) eq 'active'
            || lc($row->{status}) eq 'terminated');
    return @errors;
}

my $directory = shift or die ;

my @output = `ls $directory`;
#for my $files(glob File::Spec->catfile($directory,*.log)){
#open my $file 

say scalar @output;
foreach my $ot (@output){
chomp($ot);
if($ot =~ /.log$/ ){ 
my $filee = File::Spec->catfile($directory,$ot);
open my $fh , "<" , $filee or die ;
while(my @line = readline($fh)){say @line;}
}

if($ot =~ /.csv$/){
my $filee = File::Spec->catfile($directory,$ot);
open my $fh , "<" , $filee or die ;
while(my @line = readline($fh)){

}
}
}
