#!/usr/bin/env perl

use v5.18;
use warnings;
use Data::Dump qw/ddx/;

sub get_list {
	my $filename = shift;
	open my $in, "<", $filename || die("Could not open $filename: $!");
	local $/;
	my $data = <$in>;
	my @entries = split "\n", $data;
	return @entries;
}

sub get_prefixed_list {
	my ($prefix, $filename) = @_;
	return map { 
		my @fields = split /\s{2,}/, $_;
		sprintf("%-18s %-6s %s", $prefix, @fields);
	} get_list($filename);
}

my @titles = get_list("in.txt");
my @sources = (
	get_prefixed_list("Space: 1999", "1999.txt"),
	get_prefixed_list("Babylon 5", "b5.txt"),
	get_prefixed_list("Star Trek: DS9", "ds9.txt"),
	get_prefixed_list("Firefly", "firefly.txt"),
	);

foreach my $title (@titles) {
	say $title;
	my @matches = grep { $_ =~ /\Q$title\E/i } @sources;
	say "    $_" foreach @matches;
}
