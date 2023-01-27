#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use Text::CSV;

my $infile = shift;
my $outfile = shift;

my $csv = Text::CSV->new( { binary => 1, eol => $/ } );

open (my $fh_in, "<:encoding(utf8)", $infile) or die "Error opening input file: $!";
open (my $fh_out, ">:encoding(utf8)", $outfile) or die "Error opening output file: $!";

my $ra_colnames = $csv->getline( $fh_in );

$csv->print($fh_out, $ra_colnames);

# say $ra_colnames;

# say @{$ra_colnames}[13];

# foreach my $curr_column (@{$ra_colnames}) {
#     say $curr_column;   
# }

# $ra_line = $csv->getline($fh_in);

while (my $ra_line = $csv->getline($fh_in)) {
    my $curr_iata = @{$ra_line}[13];
    if ($curr_iata) {
        $csv->print($fh_out, $ra_line);
    }
}

close ($fh_in);
close ($fh_out);