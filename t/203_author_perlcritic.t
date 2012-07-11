#!perl -T

use strict;
use warnings;
use Test::More;
use Test::NoWarnings;

if ($ENV{'AUTHOR_TESTING'}) {
	eval "use Test::Perl::Critic;";
	if ($@) {
		plan tests => 1;
		diag("Skipping tests.  Test::Perl::Critic is not installed.");
		exit 0;
	}
	eval "use Perl::Critic::Utils;";
	if ($@) {
		plan tests => 1;
		diag("Skipping tests.  Perl::Critic::Utils is not installed.");
		exit 0;
	}
  TODO: {
		local $TODO = 'Not finished refactoring.';
		my @files           = all_perl_files('lib');
		my $number_of_files = $#files + 1;
		plan tests => $number_of_files + 1;
		foreach my $file (@files) {
			diag("begin $file");
			critic_ok($file);
			diag("end $file");
		}
	}
}
else {
	plan tests => 1;
	diag('Author tests only.');
}
