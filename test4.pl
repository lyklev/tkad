#!/usr/bin/perl
# vim: set ts=2 sw=2 expandtab :

use strict;
use warnings;

use Tk;
use Drawing;
use Drawing::Line;

# visual things
my $mw = Tk::MainWindow -> new(-title => 'test4',
                               -height => 800,
                               -width  => 600,);

my $can = $mw -> Canvas(-width => 800, -height => 600, -background => 'white');

$can -> pack();


# drawing
my $drawing = new Drawing($can);

my @vertices = (
  [1,1],
  [3,1],
  [2,2],
  [1,2],
  [1,1],
);

my $line = new Drawing::Line(@vertices);

$drawing -> add($line);

$drawing -> zoom_drawing();

$drawing -> draw();

my $label1 = $mw -> Label(
	-justify => "left",
	-text    => "Click to start drawing");

$label1 -> pack(-anchor => "w", -side => "bottom");


MainLoop();

