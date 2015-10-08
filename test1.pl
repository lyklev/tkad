#!/usr/bin/perl
#
use strict;
use warnings;

use Tk;

my $mw = Tk::MainWindow -> new(
	-height => 600,
	-width => 400,
	-title => "Main Window");

my $label1 = $mw -> Label(
	-justify => "left",
	-text    => "Hoi Pipeloi");

$label1 -> pack(-side => "bottom");


my $can1 = $mw -> Canvas(
	-background => "white",
	-width      => 600,
	-height     => 400,
);

$can1 -> pack();

MainLoop();


