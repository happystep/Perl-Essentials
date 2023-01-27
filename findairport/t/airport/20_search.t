#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use_ok('Airport::Data');
use_ok('Airport::Search'); # This should be the module you're testing

my $rah_airports = Airport::Data::parse_airports("t/data/airports1.csv");

my @tests_parse = (

  {
    string     => 'Air',
    is_word    =>  0,
    num_expected  => 5,
  },
  {
      string => 'Air',
      is_word => 1, 
      num_expected => 5,
  },
  {
      string => 'Airport',
      is_word => 1,
      num_expected => 5,
  },
  {
      string => 'Sydney',
      is_word => 0,
      num_expected => 1,
  },
  {
      string => 'Sydney',
      is_word => 1,
      num_expected => 1,
  },
      
);

foreach my $rh_test (@tests_parse) {
    my $ra_search_res = Airport::Search::get_name_matching_airports(    
        airports        => $rah_airports,
        matching_string => $rh_test->{string},
        word            => $rh_test->{is_word},
    );
      # search data from the $rh_test data

    is (ref($ra_search_res), 'ARRAY', 'is array ref');
    is (scalar(@{$ra_search_res}), $rh_test->{num_expected}, 'number expected is ok');

      # the various tests
}

my @tests_search = (
      {
        lat => 1.0,
        long => 1.0,
        max => 0.00001, 
        num_expected => 0,

    },
    {
        lat => 51.4706001282,
        long => -0.461941003799,
        max => 40.0, 
        num_expected => 2,

    },
       {
        lat => 51.4706001282,
        long => -0.461941003799,
        max => 0.00001, 
        num_expected => 1,

    },
    
);    

foreach my $rh_test (@tests_search) {
        my $ra_search_res = Airport::Search::get_latlong_matching_airports(    
        airports        => $rah_airports,
        lat => $rh_test->{lat},
        long            => $rh_test->{long},
        max => $rh_test->{max},
    );
    is (ref($ra_search_res), 'ARRAY', 'is array ref');
    is (scalar(@{$ra_search_res}), $rh_test->{num_expected}, 'number expected is ok');
    
}

# ok(1, '1 is always true');
# is(1, "1", '1 is "1" according to "is"');
# isnt(1, 0, '1 is not 0');
# FIXME write some proper tests


done_testing;
