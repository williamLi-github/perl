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












