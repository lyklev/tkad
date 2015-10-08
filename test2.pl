#!/usr/bin/perl
# vim: set ts=2 sw=2 expandtab :
use strict;
use warnings;

use Tk;
use List::Util qw/reduce min max pairs unpairs/;

my $can_width = 800;
my $can_height = 600;

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
	-width      => $can_width,
	-height     => $can_height,
);

$can1 -> pack();

draw_figure($can1);

MainLoop();

exit 0;

# ------------------------------------------------------------------------

sub sqr {
  my ($v) = @_;
  return $v * $v;
}


sub compute_coordinates {
  
  use Math::Trig ':pi';

  my $delta_x = shift;
  my $delta_y = shift;

  my @n_rows = @_;

  my @coordinates;

  my $x0 = 0.0;
  my $y0 = 0.0;

  push(@coordinates, [$x0, $y0]);

  for my $n (@n_rows) {

    # new circumference
    my $c = $n * $delta_x;

    # new radius
    my $x1 = $c / 2.0 / pi;

    my $y1 = $y0 + sqrt(max($delta_y * $delta_y - sqr($x1 - $x0), 0.0));

    push(@coordinates, [$x1, $y1]);
    $x0 = $x1;
    $y0 = $y1;
  }

  return @coordinates;
}


sub zip {
  my @r;
  for my $i (0..$#_ / 2) {
    push(@r, $_[$i], $_[$#_ / 2 + 1 + $i]);
  }
  return @r;
}

sub draw_figure {
  my $can = shift;

  my $delta_x = 1.0;
  my $delta_y = 1.5;

  my @n_rows = (10, 20, 30, 40, 45, 50, 55, 55, 55, 55);

  my @coordinate_pairs = compute_coordinates($delta_x, $delta_y, @n_rows);

  # map the coordinates
  my $canvas_width  = $can -> cget('-width');
  my $canvas_height = $can -> cget('-height');

  my @x_coordinates = map { $_ -> [0] } @coordinate_pairs;
  my @y_coordinates = map { $_ -> [1] } @coordinate_pairs;

  my $x_max = max(@x_coordinates);
  my $x_min = min(@x_coordinates);

  my $y_max = max(@y_coordinates);
  my $y_min = min(@y_coordinates);

  # margin in pixels
  my $margin = 20;

  my $x_scale = ($canvas_width  - $margin * 2) / ($x_max - $x_min);
  my $y_scale = ($canvas_height - $margin * 2) / ($y_max - $y_min);

  # use the same scale for x and y
  my $scale = min($x_scale, $y_scale);

  my @x_screen = map { $margin + ($x_min + $_) * $scale } @x_coordinates;
  my @y_screen = map { $margin + ($y_min + $_) * $scale } @y_coordinates;

  my @screen_coordinates = zip(@x_screen, @y_screen);

  $can -> createLine(@screen_coordinates);
  return;
}






