
# vim: set ts=2 sw=2 expandtab :

package Drawing::Object;

use strict;
use warnings;

sub new {
  my $package = shift;

  my $self = bless {
    'layer'     => 'default',
    'extents'   => {
      'x_min' => undef,
      'y_min' => undef,
      'x_max' => undef,
      'y_max' => undef,
    },
  }, $package;

  return $self;
}

sub layer : lvalue {
  my $self = shift;
  
  return $self -> {'layer'};
}

sub extents {
  my $self -> shift;
  return $self -> {'extents'};
}

sub update_extents {
  my $self = shift;
  my ($x, $y) = @_;

  my $extents = $self -> {'extents'};

  if (defined $extents -> {'x_min'}) {
    if ($x < $extents -> {'x_min'}) {
      $extents -> {'x_min'} = $x;
    }
  }

  if (defined $extents -> {'y_min'}) {
    if ($y < $extents -> {'y_min'}) {
      $extents -> {'y_min'} = $y;
    }
  }

  if (defined $extents -> {'x_max'}) {
    if ($x > $extents -> {'x_max'}) {
      $extents -> {'x_max'} = $x;
    }
  }

  if (defined $extents -> {'y_max'}) {
    if ($y > $extents -> {'y_max'}) {
      $extents -> {'y_max'} = $y;
    }
  }

  return $self;
}


sub draw {
  my $self = shift;
  print(STDERR "[WARNING]: Drawing::Object -> draw() called.\n");
  return;
}






# module OK
1;





