package Airport::Search;
use strict;
use warnings;
use Math::Complex;
use List::Util qw(max min);

sub get_name_matching_airports {
    my $curr = {@_};
    my $curr_airports = $curr->{airports};
    my @dereferenced = @$curr_airports;

    my @found_airports;
    foreach my $airport (@dereferenced){
        # case if word, else match_string is used
        if ($curr->{word}) {
            if ($airport->{'name'} =~ m/\b$curr->{matching_string}/i) {
                push(@found_airports, $airport);
            }
        }
        elsif ($airport->{'name'} =~ m/$curr->{matching_string}/i){
            push(@found_airports, $airport);
        }
    }
    return \@found_airports;
}

sub get_latlong_matching_airports {
    my $curr = {@_};
    my $curr_airports = $curr->{airports};
    my @dereferenced = @$curr_airports;
    my $curr_lat = $curr->{lat};
    my $curr_long = $curr->{long};
    my $curr_max = $curr->{max};
    my @found_airports;
    foreach my $airport (@dereferenced){
        my $y1 = $airport->{'latitude_deg'};
        my $x1 = $airport->{'longitude_deg'};
        my $y2 = $curr_lat;
        my $x2 = $curr_long;
        my $dist = sqrt(abs($y1 - $y2)**2 + (min(abs($x1 - $x2), abs(360 - abs($x1 - $x2))))**2); 
        if ($dist < $curr_max) {
            push(@found_airports, $airport);
        }
    }
        return \@found_airports;
}

1;
