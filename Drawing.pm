
# vim: set ts=2 sw=2 expandtab :

package Drawing;

use Tk;
use List::Util ('min', 'max');
use strict;
use warnings;


sub click1 {
  my $obj = shift;
  my $x   = shift;
  print(ref $obj, "\n");
  print("$x\n");
}


sub new {
  my $package = shift;

  my $canvas  = shift;

  unless (ref $canvas) {
    die("Drawing -> new: canvas is not a reference");
  }

  my $self = bless {
    # drawing properties ('paper size')
    'drawing_width' => 10,
    'drawing_height'=> 7,

    # view properties
    'canvas'        => $canvas,
    'margin'        => 10,
    'x_min'         => undef,
    'y_min'         => undef,
    'scale'         => undef,

    # content 
    'objects'       => [],
  }, $package;

  $self -> zoom_drawing();

  $canvas -> CanvasBind('<Button-1>',
    [$self => 'click1',
     Ev('x'),
     Ev('y')]);

  return $self;
}

# ------------------------------------------------------------------------
# Drawing object properties
# ------------------------------------------------------------------------

# read and write properties
sub margin : lvalue {
  my $self = shift;
  return $self -> {'margin'};
}

sub x_min : lvalue {
  my $self = shift;
  return $self -> {'x_min'};
}

sub y_min : lvalue {
  my $self = shift;
  return $self -> {'y_min'};
}

sub scale : lvalue {
  my $self = shift;
  return $self -> {'scale'};
}

# read-only properties
sub canvas {
  my $self = shift;
  return $self -> {'canvas'};
}

sub canvas_width {
  my $self = shift;
  return $self -> canvas -> cget('-width')
}

sub canvas_height {
  my $self = shift;
  return $self -> canvas -> cget('-height')
}

sub drawing_width : lvalue {
  my $self = shift;
  return $self -> {'drawing_width'};
}

sub drawing_height : lvalue {
  my $self = shift;
  return $self -> {'drawing_height'};
}


sub objects {
  my $self = shift;
  return @{ $self -> {'objects'} };
}

sub add {
  my $self = shift;
  my @objects = @_;

  push (@{ $self -> {'objects'}}, @objects);
}


# ------------------------------------------------------------------------
# Zoom methods
# ------------------------------------------------------------------------

# Makes sure that the whole drawing fits on the viewable area
sub zoom_drawing {
  my $self = shift;

  my $x_scale = ($self -> canvas_width - 2 * $self -> margin) / 
                $self -> drawing_width;

  my $y_scale = ($self -> canvas_height - 2 * $self -> margin) /
                $self -> drawing_height;

  $self -> scale = min($x_scale, $y_scale);
  $self -> x_min = 0;
  $self -> y_min = 0;

  return $self;
}



# ------------------------------------------------------------------------
# Drawing helper object methods
# ------------------------------------------------------------------------

sub transform_xy_to_canvas {
  my $self = shift;
  my ($x, $y) = @_;

  # these occur twice
  my $scale  = $self -> scale;
  my $margin = $self -> margin;

  return (
    $margin + $scale * ($x - $self -> x_min),
    $self -> canvas_height - $margin - $scale * ($y - $self -> y_min),
  );
}

# ------------------------------------------------------------------------
# Drawing methods
# ------------------------------------------------------------------------

# Draws all objects in this canvas using the transformation
sub draw {
  my $self = shift;
  for my $object ($self -> objects) {
    my $id = $object -> draw($self);
    $self -> {'visible_objects'}->{$id} = $object;
  }
}


# module OK
1;


