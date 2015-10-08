#!/usr/bin/perl
# vim: set ts=2 sw=2 expandtab :


use Drawing::Line;

use strict;
use warnings;


my $line = new Drawing::Line();

printf("layer = %s\n", $line->layer);

$line -> layer = "lines";

printf("layer = %s\n", $line->layer);

