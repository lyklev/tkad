package Drawing::Line;

use parent Drawing::Object;

use strict;
use warnings;

sub new {
  my $package = shift;
  my @vertices = @_;

  print("# vertices = $#vertices\n");

  my $self = $package -> SUPER::new();

  # set the extents, if there are any
  for my $vertex (@vertices) {
    #  printf("Adding vertex (%s,%s)\n", $vertex -> [0], $vertex->[1]);
    $self -> add_vertex($vertex -> [0], $vertex -> [1]);
  }

  return $self;
}


# Returns a reference to a list of vertices
sub vertices {
  my $self = shift;
  return @{ $self -> {'vertices'}};
}

sub add_vertex {
  my $self = shift;
  my ($x, $y) = @_;
  push (@{ $self -> {'vertices'} }, [$x, $y]);
  $self -> update_extents($x, $y);
  return $self;
}



sub draw {
  my $self = shift;
  my $drawing = shift;

  # coordinates list suitabable for a Canvas::Line object
  my @xys;

  for my $vertex ($self -> vertices) {

    my ($canvas_x, $canvas_y) = 
      $drawing -> transform_xy_to_canvas(@{ $vertex });

    push (@xys, $canvas_x, $canvas_y);
  }

  my $id = $drawing -> canvas -> createLine(@xys);

  return $id;
}


# module OK
1;

__END__
# vim: set ts=2 sw=2 expandtab :

