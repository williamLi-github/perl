#fix end .log
foreach my $file (glob "./log/*.log") {
	my $newfile = $file;
	$newfile =~ s/\.log$/.new/;
	if (-e $newfile) {
		warn "Can't rename $file to $newfile: $newfile exists!\n";
	}
	elsif (rename $file, $newfile) {
		print "rename $file to $newfile successfully!\n"
	}
	else {
		warn "rename $file to $newfile failed:$!\n";
	}
}
