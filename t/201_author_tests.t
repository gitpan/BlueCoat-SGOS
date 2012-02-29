#!/usr/bin/perl
#
#
use strict;
use BlueCoat::SGOS;
use Test::More;

# If we don't have environment variables, we can't test with a live box
my $env_available =
     $ENV{'AUTHOR_TESTING'}
  && $ENV{'BC_HOST'}
  && $ENV{'BC_PORT'}
  && $ENV{'BC_CONNECTMODE'}
  && $ENV{'BC_USER'}
  && $ENV{'BC_PASS'};

if (!defined($env_available)) {
	plan skip_all => 'Author tests only.';
}
else {
	plan tests => 9;

	# test 3 can create an object
	my $bc = BlueCoat::SGOS->new(
		'appliancehost'        => $ENV{BC_HOST},
		'applianceport'        => $ENV{BC_PORT},
		'applianceconnectmode' => $ENV{BC_CONNECTMODE},
		'applianceusername'    => $ENV{BC_USER},
		'appliancepassword'    => $ENV{BC_PASS},
		'debuglevel'           => 0,
	);
	ok($bc, 'can create an object');

	# test 4 get sysinfo
	ok($bc->get_sysinfo(), 'get sysinfo from appliance');
	
	# test 5 parse sysinfo
	ok($bc->parse_sysinfo(), 'parse sysinfo');
	
	# test 6 sysinfo size gt 10
	ok(length($bc->{'sgos_sysinfo'}) > 10);

	# Test 7 sgosversion looks normal
	like($bc->{'sgosversion'}, qr/\d+\.\d+\.\d+\.\d+/);

	# Test 8 sgosreleaseid looks normal
	like($bc->{'sgosreleaseid'}, qr/\d+/);

	# test 9 serialnumber looks normal
	like($bc->{'serialnumber'}, qr/\d+/);

	# model number exists (could be one of 200-10, 9000-5, VA-5, etc.)
	ok($bc->{'modelnumber'});

	# appliance-name exists
	ok($bc->{'appliance-name'});
}

