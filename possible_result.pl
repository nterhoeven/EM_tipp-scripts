#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

(my$home,my$guest)=@ARGV;

my%ranking;
my@results;
my%simulations;

open(FIFA,'<','fifa_ranking.txt') or die $!;
while(<FIFA>)
{
    chomp;
    my@line=split(/\t/,$_);
    $line[1]=~s/\s/_/g;
    $ranking{$line[0]}=$line[1];
}
close FIFA or die $!;

#print Dumper \%ranking;

open(RES,'<','results.list.sorted') or die $!;
while(<RES>)
{
    chomp;
    push(@results,$_);
}
close RES or die $!;

#print Dumper @results;

if(!exists($ranking{$home}))
{
    my$found=0;
    print "cannot find ",$home," in ranking\n";
    foreach my$key (keys %ranking)
    {
	if($key=~/$home/i)
	{
	    print "Did you mean ",$key,"?\n";
	    $found=1;
	}
    }
    print "please use one of the following Names:\n",join("\n",sort(keys(%ranking))),"\n" if $found==0;
    die;
    
}
if(!exists($ranking{$guest}))
{
    my$found=0;
    print "cannot find ",$guest," in ranking\n";
    foreach my$key (keys %ranking)
    {
	if($key=~/$guest/i)
	{
	    print "Did you mean ",$key,"?\n";
	    $found=1;
	}
    }
    print "please use one of the following Names:\n",join("\n",sort(keys(%ranking))),"\n" if $found==0;
    die;
    
}


my$sum=$ranking{$home}+$ranking{$guest};
my$chance_home=$ranking{$home}/$sum;

#print "sum: ",$sum,"\nchance: ",$chance_home,"\n";

for(my$i=0;$i<100;$i++)
{
    my$winner;
    my$result=$results[rand(@results+0)];
    if(rand()<$chance_home)
    {
	$winner=$home;
    }
    else
    {
	$winner=$guest;
    }
    $simulations{$winner.'_'.$result}++;

}

#print Dumper\%simulations;

# Ausgabe numerisch nach Values sortiert
#foreach my$value (sort {$b<=>$a} values %simulations)
#{
#    print "$value\n";
#}

my@keys = sort {$simulations{$b}<=>$simulations{$a}} keys %simulations;  
my($won,$res)=$keys[0]=~/(\w+)_(.*)/;

if($won eq $home)
{
    my$real=reverse $res;
    print $home," ",$real," ",$guest,"\n";
}
else
{
    print $home," ",$res," ",$guest,"\n";
}
#print $keys[0],"\tcount: ",$simulations{$keys[0]},"\n",$keys[1],"\tcount: ",$simulations{$keys[1]},"\n",$keys[2],"\tcount: ",$simulations{$keys[2]},"\n";



