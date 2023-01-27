#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use Data::Types qw(is_float);
use_ok('Airport::Data');

my $rah_airports = Airport::Data::parse_airports("t/data/airports1.csv");

# Essentially the same as:
#     use Airport::Data;
# but outputting:
#     ok 1 - use Airport::Data;
# to indicate that the module loaded successfully.
is(ref($rah_airports), 'ARRAY', 'parse_airports returns the correct type');
is(scalar(@{$rah_airports}), 5, 'correct number');
foreach my $var (@{$rah_airports}) {
    ok(is_float($var->{latitude_deg}), 'is a floating point');
    ok(is_float($var->{longitude_deg}), 'is a floating point');

}

# is($test_val, $expected_val, 'the test value is as expected')

ok(1, 'non zero is good ');
#ok(0, 'zero is bad');

done_testing();
# Note, without done_testing at the end
# it will suspect the test script died part way through.
