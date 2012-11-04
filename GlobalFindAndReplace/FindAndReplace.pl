#!/usr/bin/perl

use strict;
use warnings;
use File::Find;
use Cwd;

print "Hello, world!\n";

sub get_lines {
   my($file) = @_;

   open (FH, "< $file") or die "Can't open $file for read: $!";
   my(@lines) = <FH>;
   close FH or die "Cannot close $file: $!";

   return @lines;
}

sub wanted {
   return unless -f;
   return unless $_ =~ /.*txt$/; 

   my(@lines) = &get_lines($_);


   print $File::Find::name, "\n";
   print @lines;
   print "\n\n";
   
}
  
find \&wanted, ".";