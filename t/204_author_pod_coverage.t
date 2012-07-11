#!perl -wT
#
#
use strict;
use warnings;
use Test::More;
use Test::NoWarnings;

if ($ENV{'AUTHOR_TESTING'}) {

	# Ensure a recent version of Test::Pod::Coverage
	my $min_tpc = 1.08;
	eval "use Test::Pod::Coverage $min_tpc";
	if ($@) {
		plan tests => 1;    # just the warning
		diag("Skipping tests.  Test::Pod::Coverage $min_tpc required for testing POD coverage.");
		exit 0;
	}

	my $min_pc = 0.18;
	eval "use Pod::Coverage $min_pc";
	if ($@) {
		plan tests => 1;    # just the warning
		diag("Skipping tests.  Pod::Coverage $min_pc required for testing POD coverage.");
		exit 0;
	}

	# ok, Test::Pod::Coverage and Pod::Coverage check out ok
	my @modules           = all_modules('lib');
	my $number_of_modules = $#modules + 1;
	plan tests => $number_of_modules + 1;
	foreach my $module (@modules) {
		note("begin $module");
		pod_coverage_ok($module);
		note("end $module");
	}
}
else {
	plan tests => 1;
	diag('Author tests only.');
}

