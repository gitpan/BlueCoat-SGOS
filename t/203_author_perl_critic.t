use strict;
use warnings;
use Test::More;

if ($ENV{'AUTHOR_TESTING'}) {
	if (eval { require Test::Perl::Critic }) {
		Test::Perl::Critic::all_critic_ok();
	}
	else {
		plan skip_all => "Couldn't load Test::Perl::Critic.";
	}
}
else {
	plan
	  skip_all => 'Author tests only.',
	  ;
}

