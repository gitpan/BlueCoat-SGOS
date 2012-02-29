#!/usr/bin/perl
#
#
#
use strict;
use lib qw#../lib #;
use BlueCoat::SGOS 1.00;
use Getopt::Long;
use Date::Format;
use Data::Dumper;

my %c = (
	'appliancehost'     => '',
	'applianceport'     => 8082,
	'applianceusername' => 'admin',
	'appliancepassword' => '',
	'timestamp'         => time2str('%Y%m%d-%H%M%S%Z', time, 'UTC')
);

my $d = GetOptions(
	'appliancehost=s'     => \$c{'appliancehost'},
	'applianceport=i'     => \$c{'applianceport'},
	'applianceusername=s' => \$c{'applianceusername'},
	'appliancepassword=s' => \$c{'appliancepassword'}
);

my $bc = BlueCoat::SGOS->new(
	'appliancehost'     => $c{'appliancehost'},
	'applianceport'     => $c{'applianceport'},
	'applianceuser'     => $c{'applianceusername'},
	'appliancepassword' => $c{'appliancepassword'},
	'debuglevel'		=>	1
);
$bc->get_sysinfo();
# Don't spend the time parsing the sysinfo file
# when all we need is the serial number
($c{'appliance_serial_number'}) =
  $bc->{'sgos_sysinfo'} =~ m/Serial number is (\d+)/;
if (!defined($c{'appliance_serial_number'})) {
	$c{'appliance_serial_number'} = 'unknown';
}

$c{'filename'} = $c{'appliance_serial_number'} . '--' . $c{'timestamp'} . '.sysinfo';

print "Filename=$c{'filename'} \n";
if ($bc->{'sgos_sysinfo'} ) {
	open (F,">$c{'filename'}");
	print F $bc->{'sgos_sysinfo'};
	close F;
}

