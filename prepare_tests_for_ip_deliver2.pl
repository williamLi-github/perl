#!/usr/bin/perl -w
use strict;
use Getopt::Long
# ------------------------------------------
# Filename    : prepare_tests_for_ip_deliver.pl                  
#     
# Description:                              
#      The script used to prepare the test patterns
#      for ip release
#                                           
# Author:                                   
#     WilliamLi    willimLi-github@github.com
# ------------------------------------------
#  prepare_tests_for_ip_deliver.pl    

my $output_name = "test_pattern";
my $tar_format     = "tar";  # .tar.gz  or  .tar, can be modified by option
my $case_list        = "./env_log/case_list":
my $cfg_dir           = "./env_log/sim_log";
my $stream_path   = "./env_log/test_streams":
my $help               = 0;
my $debug             = 0;
my $verbose          = 0;
my $tab                 = "-"x4;

my @cases;
my $cur_dir;
my $ERROR  = "[ERROR] --";
my $INFO     = "[INFO] --";
my @not_generated_list;
my @generated_list;


GrtOptions(
			'package_name=s'        => \$output_name,
			'tar_format=s'              => \$tar_format,
			'case_list=s'                 => \$case_list,
			'cfg_dir=s'                    => \$cfg_dir,
			'stream_path=s'            => \$stream_path,
			'help!'                          => \$help,
			'debug!'                        => \$debug,
			'verbose'                      => \$verbose,
);























