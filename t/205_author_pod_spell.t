#perl
#
#
#
use Test::More;

if ($ENV{'AUTHOR_TESTING'} ) {
	eval "use Test::Spelling";
	plan skip_all => "Test::Spelling not found" if $@;

	set_spell_cmd('aspell list');
	add_stopwords(<DATA>);
	all_pod_files_spelling_ok();
}
else {
	plan skip_all => 'Author tests only.';
}

__DATA__
AnnoCPAN
bluecoat
CPAN
filename
lange
login
sgos
SGOS
sysinfo
VPM
vpmcpl
vpmxml
