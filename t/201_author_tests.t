#!/usr/bin/perl -wT
#
#
use strict;
use BlueCoat::SGOS;
use Test::More;
use Test::NoWarnings;

# If we don't have environment variables, we can't test with a live box
my $env_available =
     $ENV{'AUTHOR_TESTING'}
  && $ENV{'BC_HOST'}
  && $ENV{'BC_PORT'}
  && $ENV{'BC_CONNECTMODE'}
  && $ENV{'BC_USER'}
  && $ENV{'BC_PASS'};

if (!defined($env_available)) {
	plan tests => 1;
	diag('Author tests only.');
	exit 0;
}
else {
	plan tests => 11;

	# test 3 can create an object
	my $bc = BlueCoat::SGOS->new(
		'appliancehost'        => $ENV{BC_HOST},
		'applianceport'        => $ENV{BC_PORT},
		'applianceconnectmode' => $ENV{BC_CONNECTMODE},
		'applianceusername'    => $ENV{BC_USER},
		'appliancepassword'    => $ENV{BC_PASS},
		'debuglevel'           => 0,
	);
	isa_ok($bc, 'BlueCoat::SGOS');

	# test 4 get sysinfo
	ok($bc->get_sysinfo(), 'get sysinfo from appliance');

	# test 5 parse sysinfo
	ok($bc->parse_sysinfo(), 'parse sysinfo');

	# test 6 sysinfo size gt 10
	ok(length($bc->{'sgos_sysinfo'}) > 10, "length of sysinfo=" . length($bc->{'sgos_sysinfo'}));

	# Test 7 sgosversion looks normal
	like($bc->{'sgosversion'}, qr/\d+\.\d+\.\d+\.\d+/, "sgosversion=$bc->{'sgosversion'}");

	# Test 8 sgosreleaseid looks normal
	like($bc->{'sgosreleaseid'}, qr/\d+/, "sgosreleaseid=$bc->{'sgosreleaseid'}");

	# test 9 serialnumber looks normal
	like($bc->{'serialnumber'}, qr/\d+/, "serialnumber=$bc->{'serialnumber'}");

	# model number exists (could be one of 200-10, 9000-5, VA-5, etc.)
	ok($bc->{'modelnumber'}, "modelnumber=$bc->{'modelnumber'}");

	# is model supported
	ok(exists($bc->{'supported_configuration'}), "supported_configuration=$bc->{'supported_configuration'}");

	# appliance-name exists
	ok($bc->{'appliance-name'}, "appliance-name=$bc->{'appliance-name'}");
}

