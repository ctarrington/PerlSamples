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

sub write_lines {
   my($file, @lines) = @_;

   open (FH, "> $file") or die "Can't open $file for write: $!";
   
   foreach (@lines) {
      print FH;
   }

   close FH or die "Cannot close $file: $!";

   return @lines;
}

sub replace_lines {
   my(@lines) = @_;
   my(@replacements);
   
   foreach (@lines) {
       if(/^%/) {  
          print "cl = $_  \n";
          s/foo/bar/g;
          push(@replacements, $_);
       }
       else {
           push(@replacements, $_);
       }
   }

   return @replacements;
}

sub wanted {
   return unless -f;
   return unless $_ =~ /.*txt$/; 

   my(@lines) = &get_lines($_);
   my(@replacements) = &replace_lines(@lines);
   &write_lines($_, @replacements);

   print @replacements;
   print "\n\n";
   
}
  
find \&wanted, ".";