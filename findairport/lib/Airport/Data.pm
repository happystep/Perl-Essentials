#!/usr/bin/perl
package Airport::Data;
use strict;
use warnings;
use Data::Dump 'pp';
use feature 'say';
use Getopt::Long;
use Text::CSV;

sub parse_airports {
    my $file = shift;
    my $csv = Text::CSV->new( { binary => 1, eol => $/ } );
    open (my $fh, "<:encoding(utf8)", $file) or die "Error opening input file: $!";
    my $ra_colnames = $csv->getline( $fh );
    $csv->column_names(@$ra_colnames);
    my $ra_airports = $csv->getline_hr_all($fh);
}

sub get_name_matching_airports {
    my $curr = {@_};
    my $curr_airports = $curr->{airports};
    my @dereferenced = @$curr_airports;
    my @found_airports;
    foreach my $airport (@dereferenced){
        # case if word, else match_string is used
        if ($curr->{word}) {
            if ($airport->{'name'} =~ m/\b$curr->{word}/i) {
                push(@found_airports, $airport);
            }
        }
        elsif ($airport->{'name'} =~ m/$curr->{matching_string}/i){
            push(@found_airports, $airport);
        }
    }
    return \@found_airports;
}


# my $rah_airports = parse_airports($filename);
# my $rah_airports_found = [];
# my $word; # In preparation for the next exercise    

# if ($matching) {
#   say "Up to $number airports matching $matching in $filename:"; 
#   $rah_airports_found = get_name_matching_airports(
#     airports        => $rah_airports,
#     matching_string => $matching,
#     word            => $word,
#   );
# }
# elsif ($latitude && $longitude) {
#   say "Up to $number airports near [$latitude, $longitude] in $filename:"
# }
# else {
#   say "Must have at least --matching, or --latitude and --longitude as arguments";
# }

# print pp($rah_airports_found);

1;

