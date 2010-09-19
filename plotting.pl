#!/usr/local/bin/perl -w
#-
# Copyright (c) 2009 Aditya Sarawgi
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#

use GD::Graph::lines;
use GD::Text;
use POSIX;
use warnings; 
#use strict;
# File handles for writting the sorted data
open OUTPUTSIW, ">sorted_initial_write.txt";
open OUTPUTSRW, ">sorted_rewrite.txt";
open OUTPUTSR,  ">sorted_read.txt";
open OUTPUTSRR, ">sorted_reread.txt";
open OUTPUTSRV, ">sorted_reverse_read.txt";
open OUTPUTSSR, ">sorted_stride_read.txt";
open OUTPUTSRA, ">sorted_random_read.txt";
open OUTPUTSMW, ">sorted_mixed_workload.txt";
open OUTPUTSRAW,">sorted_random_write.txt";
open OUTPUTSPW, ">sorted_pwrite.txt";
open OUTPUTSPR, ">sorted_pread.txt";

# File handle arrays for input raw data
my @oldfile;
my @newfile;
# File handle array initialisation
for (my $i=4; $i<16385; $i=$i*4){
	local *FILE1;
	local *FILE2;
	open(FILE1, "<resultsnew$i.txt") || die;
	open(FILE2, "<resultsold$i.txt") || die;
	push(@newfile, *FILE1);
	push(@oldfile, *FILE2);
}
# Reverse array so that pop can be used
@newfile = reverse(@newfile);
@oldfile = reverse(@oldfile);
my $counter = 1;

# Loop for pattern matching 
for(my $j=0; $j < 7;$j++){
	my $newf = pop(@newfile);
	my $oldf = pop(@oldfile);	
	my $initialstring = undef;	
	my $rewritestring = undef;
	my $readstring = undef;
	my $rereadstring = undef;
	my $reversestring = undef;
	my $stridestring = undef;
	my $randomreadstring = undef;
	my $randomwritestring = undef;
	my $mixedstring = undef;
	my $pwritestring = undef;
	my $preadstring = undef;
	
	$counter *= 4;

	while (<$newf>){
		if( m/\"(\s+)Initial write\s\"(\s+)(\d+)/ ){
		$initialstring .= " ".ceil($3/1024);
		}
	 	if( m/\"(\s+)Rewrite\s\"(\s+)(\d+)/ ){
		$rewritestring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Read\s\"(\s+)(\d+)/ ){
		$readstring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Re-read\s\"(\s+)(\d+)/ ){
		$rereadstring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Reverse Read\s\"(\s+)(\d+)/ ){
		$reversestring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Stride read\s\"(\s+)(\d+)/ ){
		$stridestring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Random read\s\"(\s+)(\d+)/ ){
		$randomreadstring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Mixed workload\s\"(\s+)(\d+)/ ){
		$mixedstring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Random write\s\"(\s+)(\d+)/ ){
		$randomwritestring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Pwrite\s\"(\s+)(\d+)/ ){
		$pwritestring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Pread\s\"(\s+)(\d+)/ ){
		$preadstring .= " ".ceil($3/1024);
		}
	}
	while (<$oldf>){
		if( m/\"(\s+)Initial write\s\"(\s+)(\d+)/ ){
		$initialstring .= " ".ceil($3/1024);
		}
	 	if( m/\"(\s+)Rewrite\s\"(\s+)(\d+)/ ){
		$rewritestring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Read\s\"(\s+)(\d+)/ ){
		$readstring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Re-read\s\"(\s+)(\d+)/ ){
		$rereadstring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Reverse Read\s\"(\s+)(\d+)/ ){
		$reversestring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Stride read\s\"(\s+)(\d+)/ ){
		$stridestring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Random read\s\"(\s+)(\d+)/ ){
		$randomreadstring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Mixed workload\s\"(\s+)(\d+)/ ){
		$mixedstring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Random write\s\"(\s+)(\d+)/ ){
		$randomwritestring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Pwrite\s\"(\s+)(\d+)/ ){
		$pwritestring .= " ".ceil($3/1024);
		}
		if( m/\"(\s+)Pread\s\"(\s+)(\d+)/ ){
		$preadstring .= " ".ceil($3/1024);
		}
	}
#	print "$reversestring\n";
	print OUTPUTSIW  "$counter$initialstring\n";
	print OUTPUTSRW   "$counter$rewritestring\n";
	print OUTPUTSR   "$counter$readstring\n";
	print OUTPUTSRR  "$counter$rereadstring\n";
	print OUTPUTSRV  "$counter$reversestring\n";
	print OUTPUTSSR  "$counter$stridestring\n";
	print OUTPUTSRA  "$counter$randomreadstring\n";
	print OUTPUTSMW  "$counter$mixedstring\n";
	print OUTPUTSRAW "$counter$randomwritestring\n";
	print OUTPUTSPW  "$counter$pwritestring\n";
	print OUTPUTSPR  "$counter$preadstring\n";

}

close OUTPUTSIW;
close OUTPUTSRW;
close OUTPUTSR;
close OUTPUTSRR;
close OUTPUTSRV;
close OUTPUTSSR;
close OUTPUTSRA;
close OUTPUTSMW;
close OUTPUTSRAW;
close OUTPUTSPW;
close OUTPUTSPR;

open INPUTSIW, "<sorted_initial_write.txt";
open INPUTSRW, "<sorted_rewrite.txt";
open INPUTSR,  "<sorted_read.txt";
open INPUTSRR, "<sorted_reread.txt";
open INPUTSRV, "<sorted_reverse_read.txt";
open INPUTSSR, "<sorted_stride_read.txt";
open INPUTSRA, "<sorted_random_read.txt";
open INPUTSMW, "<sorted_mixed_workload.txt";
open INPUTSRAW,"<sorted_random_write.txt";
open INPUTSPW, "<sorted_pwrite.txt";
open INPUTSPR, "<sorted_pread.txt";

my @input_files;
push @input_files, INPUTSIW, INPUTSRW, INPUTSR, INPUTSRR, INPUTSRV, INPUTSSR, INPUTSRA, INPUTSMW, INPUTSRAW, INPUTSPW, INPUTSPR ;
my @namelist = qw# pread pwrite random_write mixed_workload random_read stride_read reverse_read re-read read rewrite initial_write #;
foreach my $input (@input_files) {  
	my @append_new = ();
	my @append_old = ();
	my @data = (['4KB', '16KB', '64KB', '256KB', '1MB', '4MB', '16MB']);
	while (<$input>){
		if(m/(\d+)\s+(\d+)\s+(\d+)/){
		push @append_new, "$2 ";
		push @append_old, "$3 ";
		} 	
	}
	#print @append_new;
	push @data, [@append_new], [@append_old];
#	print "@data";
	my $mygraph = GD::Graph::lines->new(350, 325);
	$mygraph->set(
    	x_label     => 'I/O Size',
    	y_label     => 'Megabytes Per Second',
    	title       => "$namelist[-1]",
    	# Draw datasets in 'solid', 'dashed' and 'dotted-dashed' lines
    	line_types  => [1, 1],
    	# Set the thickness of line
    	line_width  => 2,
    	long_ticks => 1,
    	# Set colors for datasets
    	dclrs       => ['red', 'blue'],
    	bgclr => 'white',
	) or warn $mygraph->error;

	$mygraph->set_title_font('/fonts/arial.ttf', 18);
    	$mygraph->set_legend_font(gdTinyFont);
    	$mygraph->set_legend_font(
        ['verdana', 'arial', gdMediumBoldFont], 12);
	$mygraph->set_legend_font(GD::gdMediumBoldFont);
	$mygraph->set_legend('New', 'Old');
	my $myimage = $mygraph->plot(\@data) or die $mygraph->error;

	# Open a file for writing
	open(PICTURE, ">$namelist[-1]_picture.jpeg") or die("Cannot open 
	file for writing");
	pop @namelist;
	# Make sure we are writing to a binary stream
	binmode PICTURE;

	# Convert the image to PNG and print it to the file PICTURE
	print PICTURE $myimage->jpeg;
	close PICTURE;
}

