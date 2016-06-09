#!/usr/bin/perl
use strict;
use warnings;

my($team1,$team2)=@ARGV;

#print random numbers between 0 and 5 as results
print $team1," ",int(rand(6))," : ",int(rand(6))," ",$team2,"\n";
