#!perl -w
#
#
#
use warnings;
use Test::More;
use Test::NoWarnings;

if ($ENV{'AUTHOR_TESTING'}) {
	eval {require Test::Kwalitee;};
	if ($@) {
		plan tests => 1;
		diag("Skipping tests.  Test::Kwalitee not found");
		exit 0;
	}
	plan tests               => 2;
	subtest 'Kwalitee Tests' => sub {
		Test::Kwalitee->import();
	  }
}
else {
	plan tests => 1;
	diag('Author tests only.');
}

