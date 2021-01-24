#!/usr/bin/perl -w
use strict;
use Getopt::Long;
# ------------------------------------------
# Filename    : gen_test_env.pl                  
#     
# Description:                              
#      the script used to generate the test
#      environment for the example that prepare
#      the test patterns for ip deliver                                     
#
# Author:                                   
#     WilliamLi 
# ------------------------------------------
#  gen_test_env.pl    

# ----------------------------------------------
# case list    : $env_dir/case_list
# cfg_files    : $env_dir/sim_log/log_case_id/*.cfg
# test streams : $env_dir/test_streams/case_id/stream.mpeg2
# ----------------------------------------------
my $env_dir     = "./env_log";
my $case_list   = "case_list";
my $cfg_dir     = "sim_log";
my $stream_dir  = "test_streams";
my $case_num    = 20;
my @cases;
my $help = 0;
my $debug = 0;
my $tab = " "x4;

GetOptions(
			'env_dir=s'    => \$env_dir,
			'case_list=s'  => \$case_list,
			'cfg_dir=s'    => \$cfg_dir,
			'stream_dir=s' => \$stream_dir,
			'case_num=s'   => \$case_num,
			'help!'        => \$help,
			'debug!'       => \$debug,
);

&help_msg() if $help;

&check_dirs();

&gen_case_list($case_list, $case_num, 3000, 500);

&gen_cfg_files($cfg_dir, \@cases);

&gen_test_streams($stream_dir, \@cases);


sub check_dirs {
	$env_dir =~ s#\$|/$##;
	$case_list = "${env_dir}/${case_list}";
	$cfg_dir   = "${env_dir}/${cfg_dir}";
	$stream_dir= "${env_dir}/${stream_dir}";
	&adjust_dir($env_dir);
	&adjust_dir($cfg_dir);
	&adjust_dir($stream_dir);
}

sub adjust_dir {
	my $cur_dir  = shift;
	if(-e $cur_dir) {
		system("rm -rf $cur_dir/*");
	} else {
		system("mkdir $cur_dir");
	}
}

# --------------------------------------------------------------
# the sub program used to generate the test case list file for
# test the compare_caselist.pl script
#
# parameters:
#       $file      -- the file name that used to save the
#				   -- generated test case ids
#       $num       -- how many test case ids will be generated
#       $start_val -- the test case id's start value
#       max_val    -- the max value for the rand value
#----------------------------------------------------------------
sub gen_case_list {
	my ($file, $num, $start_val, $max_val) = @_;
	my $case_info = "";
	print "\n[INFO] -- start to generate the test case list file\n\n";
	$case_info .= "# The following is a test case list for our project:\n\n";
	for (my $i = 0; $i < $num; $i++) {
		# just to generate 3same test case id
		my $case_id = $start_val + int(rand($max_val));
		print "[INFO] -- the generated case id = $case_id \n" if $debug;
		$case_info .= "$case_id "         if (($case_id % 3) == 0);
		$case_info .= "$case_id \n"       if (($case_id % 3) == 1);
		$case_info .= "$case_id \n\n"     if (($case_id % 3) == 2);
		push (@cases, $case_id) if (defined $cases[0] && (!(grep ($case_id =~ /^$_$/) @cases)));
		push (@cases, $case_id) if (!defined $cases[0]);
	}
	open (LIST, ">", $file) or die "Can not open $file for writing!\n\n";
	print LIST $case_info;
	close (LIST);
	print "[INFO] -- a test case list has been written into $file file \n\n";
}




sub help_masg {
	my $str = "";
	# system("pod2text $0");  # for help info in pod format
	print "\n$0 used to generate the test environment for the prepare test patterns for ip deliver script\n\n";
	print "Usage: perl $0 OPTIONS\n\n";
	print "OPTIONS:\n";
	print "-"x40 . "\n";
	print "${tab}-env_dir    env_dir      -- specify the generated environment path\n";
	print "${tab}-case_list  list_name    -- specify the generated case list file name\n";
	print "${tab}-cfg_dir    cfg_dir      -- specify the generated cfg files' path\n";
	print "${tab}-stream_dir stream_dir   -- specify the generated test stream's path\n";
	print "${tab}-case_num   case_num     -- specify the case number that will be generated for deliver\n";
	print "${tab}-help                    -- print out this help infor\n";
	print "${tab}-debug                   -- print out some infor for debug\n";
	exit;	
}















