use strict;
use warnings;
use feature 'say';

use POSIX qw(strftime);
say localtime();
say strftime("%Y-%m-%d %H:%M:%S" , localtime());
