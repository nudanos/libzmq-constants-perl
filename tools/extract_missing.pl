#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;
use ZMQ::Constants qw//;

my ($header_file) = @ARGV;

my %LOOKUP = map { $_ => 0 } @{ $ZMQ::Constants::EXPORT_TAGS{all} };

open( my $fh, "<", $header_file ) or die "$header_file: $!\n";
my @lines = <$fh>;
close($fh) or die "$header_file: $!\n";

foreach my $line (@lines) {
    chomp($line);

    foreach my $cst ( sort keys %LOOKUP ) {
        next if $LOOKUP{$cst};

        if (
            $line =~ m/
                #define
                \s+
                $cst\s+\w+/x
          )
        {
            $LOOKUP{$cst}++;
        }

    }
}

while ( my ( $k, $v ) = each %LOOKUP ) {
    next if $v;
    say $k;
}

1;
