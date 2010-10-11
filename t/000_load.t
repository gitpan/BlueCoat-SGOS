#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'BlueCoat::SGOS' ) || print "Bail out!\n";
}

diag( "Testing BlueCoat::SGOS $BlueCoat::SGOS::VERSION, Perl $], $^X" );
