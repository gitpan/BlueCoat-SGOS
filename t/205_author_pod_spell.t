#!perl -w
#
#
#
# can't use taint mode here because Test::Spelling doesn't like it
use warnings;
use Test::More;
use Test::NoWarnings;

if ($ENV{'AUTHOR_TESTING'}) {
	eval "use Test::Spelling";
	if ($@) {
		plan tests => 1;
		diag("Skipping tests.  Test::Spelling not found.");
		exit 0;
	}
	set_spell_cmd('/usr/bin/aspell list');
	add_stopwords(<DATA>);

	my @files           = all_pod_files('lib');
	my $number_of_files = $#files + 1;
	plan tests => $number_of_files + 1;
	foreach my $file (@files) {
		note("begin $file");

		#pod_file_spelling_ok($file, "spelling for $file");
		pod_file_spelling_ok($file);
		note("end $file");
	}
}
else {
	plan tests => 1;
	diag('Author tests only.');
}

__DATA__
AnnoCPAN
bluecoat
CPAN
filename
Lange
login
sgos
SGOS
sysinfo
VPM
vpmcpl
vpmxml

