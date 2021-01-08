#!/usr/bin/perl -w
use strict;
# ------------------------------------------
# Filename    : parse_sim_log_and_gen_report.pl                  
#     
# Description:                              
#      
#      
#                                           
# Author:                                   
#     WilliamLi 
# ------------------------------------------
#  parse_sim_log_and_gen_report.pl    
use Getopt::Long;
use Spreadsheet::WriteExcel;

my $log_dir = "./out";
my $report_file = "simulation_report.log";
my $verbose = 0;
my $debug = 0;
my $help = 0;
my $tab = " "x4;
my $excel_en = 0;
my $info = "[INFO] --";
my $error = "[ERROR] --";
my @pass_cases;
my @fail_cases;
my @unknown_cases;

GetOptions(
	'log_dir=s' => \$log_dir,
	'excel!'    => \$excel_en,
	'verbose!'  => \$verbose,
	'debug!'    => \$debug,
	'help!'     => \$help,
);
