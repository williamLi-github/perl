#!/usr/bin/perl -w
use strict;
# ------------------------------------------
# Filename    : gen_sim_logs.pl                  
#     
# Description:                              
#      The scipt used to generate the simulation
#      log files by random
#      
#                                           
# Author:                                   
#     WilliamLi williamLi-github 
# ------------------------------------------
#  gen_sim_logs.pl    
my $ref_log_file = "ref_simv.log";
my $ref_log = "";
my $out_dir = "./out";
my $log_num = 200;
my $tab = " "x4;
my $verbose = 0;
my $debug = 0;

print "\n";

&obtain_ref_log($ref_log_file);

&gen_real_log_files($ref_log, $log_num, $out_dir);

sub obtain_ref_log {
	my $file = shift;
	open (LOG, "<", $file) or die "Can not open $file for reading!\n";
	while (defined (my $file = <LOG>)) {
		$ref_log .= $line;
	}
	close(LOG);
	print "[DEBUG] -- complete to obtain the reference simulation log\n\n";
}

sub gen_real_log_files {
	my ($log, $num, $dir) = @_;
	my $start_val = 2000;
	my $max_val = 500;
	my @cases;
	my $count = 0;
	print "[DEBUG] -- Start to geneate $num log files...\n\n";
	&adjust_out_dir(\$dir);
	while ($count < ($num + 1)) {
		my $case_id = $start_val + int($max_val);
		if (!(grep {$case_id =~ /^$_$/} @cases)) { 
			push (@cases, $case_id);
			$count++;
			&gen_one_log_file($case_id, $log, $dir);
		}
	}
	print "[DEBUG] -- Complete to generate the $num log files into $dir\n\n";
}

sub gen_one_log_file {
	my ($id, $log, $dir) = @_;
	my $sim_file = "${dir}/sim_${id}.log";
	my $result = "$log";
	my $status;
	my $max_val = 4000;
	my $rand_val = int(rand($max_val));
	$status = "OK"  if ($rand_val > ($max_val / 5));
	$status = "FAIL"  if ($rand_val <= ($max_val / 5));
	
	$result .= &obtain_sim_status($status, $id);
	
	#output the generated simulation log for current test
	open (OUT, ">", $sim_file) or die "Can not open $sim_file for writing!\n";
	print OUT $result;
	close(OUT);
	print "${tab}[DEBUG] -- the $sim_file has been generated!\n" if $verbose;
	
}

sub obtain_sim_status {
	my ($status, $id) = @_;
	my $str = "";
	$str .= "# " . "="x30 . "\n";
	$str .= "# test_id     : $case_id\n";
	$str .= "# test_status : $status\n";
	$str .= "# " . "="x30 . "\n";
	return $str;
}

sub adjust_out_dir {
	my $dir_ref = shift;
	$$dir_ref =~ s#\$|/$##g;
	if(-e $$dir_ref) {
		unlink glob("$$dir_ref/*");
		print "${tab}[DEBUG] -- $$dir_ref dir exist and complete to clean up its content\n\n";
	}
	else {
		mkdir "$$dir_ref" . 0755 or die "Can not creat $$dir_ref!\n";
		print "${tab}[DEBUG] -- $$dir_ref dir do not exist and complete to creat it\n\n";
	}
}
