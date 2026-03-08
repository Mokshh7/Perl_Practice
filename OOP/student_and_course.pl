use strict;
use feature 'say';
use warnings;

package Course;
 
sub new {
my ($class,$course_id,$course_name) = @_;
my $self = {
course_id => $course_id,
course_name => $course_name,
};
bless $self,$class;
}

sub get_course_id{
return $_[0]->{course_id};
}


sub get_course_name{
return $_[0]->{course_name};
}

package student;

sub new{
my ($class , $id , $name) = @_;
my $self = {
id => $id,
name => $name,
courses => [],
};
return bless $self,$class;
}

sub enroll{
my ($self,$course_obj) = @_;
push @{ $self->{courses}}, $course_obj ;
}


sub list_courses{
my ($self) = @_; 
}

sub list_courses{
my ($self) = @_;
say "courses for $self->{name}";

foreach my $course(@{$self->{courses} }){

say "- " . $course->get_course_id();
 say ": " . $course->get_course_name();

}
}

package main;

# Create courses
my $course1 = Course->new("CS101", "Data Structures");
my $course2 = Course->new("CS102", "Algorithms");
my $course3 = Course->new("CS103", "Operating Systems");

my $student = student->new(1,"Alice");

$student->enroll($course1);
$student->enroll($course2);
$student->enroll($course3);

$student->list_courses();
