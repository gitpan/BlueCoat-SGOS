#!perl -T

use strict;
use warnings;
use Test::More;
use Test::NoWarnings;

if ($ENV{'AUTHOR_TESTING'}) {
	my $min_tp = 1.22;
	eval "use Test::Pod $min_tp";
	if ($@) {
		plan tests => 1;
		diag("Skipping tests.  Test::Pod $min_tp required for testing POD");
		exit 0;
	}
	my @files = all_pod_files('lib');

	# because $#files=0 is actually 1 file
	my $number_of_files = $#files + 1;
	plan tests => $number_of_files + 1;
	foreach my $file (@files) {
		note("begin $file");
		pod_file_ok($file);
		note("end $file");
	}
}
else {
	plan tests => 1;
	diag('Author tests only.');
}

