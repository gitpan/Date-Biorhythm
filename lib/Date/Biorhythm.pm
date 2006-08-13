package Date::Biorhythm;

use Date::Business;
use Carp;
use Data::Dumper;

require 5.005_62;
use strict;
use warnings;

our $VERSION = sprintf '%s', q{$Revision: 1.2 $} =~ /\S+\s+(\S+)/;

# Preloaded methods go here.

our %birth;
our $birth;

sub new_date {
  carp "A: @_";
  return Date::Business->new unless @_;
  my %hash = @_;
  my $s = sprintf '%4d%02d%2d', $hash{year}, $hash{month}, $hash{day};
  warn $s;
  Date::Business->new(DATE => $s);
}

sub birth {
  shift and $birth = new_date(@_);
}

our %wavelength = (
  emotional    => 28,
  intellectual => 33,
  intuitional  => 38,
  physical     => 23
);

our %doi;
our $doi;

our %position;

sub next {
  $doi->next();
}

sub prev {
  $doi->prev();
}

sub chart {
  shift and $doi = new_date(@_);
  printf "Birth Date:\t%s\n", $birth->image;
  printf "Chart Date:\t%s\n", $doi->image;
  my $diff = $doi->diff($birth);
  printf "Difference:\t%d days\n", $diff;

  for (keys %wavelength) {
    $position{$_} = $diff % $wavelength{$_};
  }

  for (keys %position) {
    printf "you are at day %02d of %d in your %s cycle\n", $position{$_}, $wavelength{$_}, $_;
  }
}

sub mk_method_for_position {
  my $class    = shift;
  my $position = shift;
  {
    no strict 'refs';
    *{$position} = sub {
      my $diff = $doi->diff($birth);
      return $diff % $wavelength{$position};
    };
  }
}

Date::Biorhythm->mk_method_for_position('intellectual');
Date::Biorhythm->mk_method_for_position('physical');
Date::Biorhythm->mk_method_for_position('emotional');
Date::Biorhythm->mk_method_for_position('intuitional');

1;

__END__

=head1 NAME

Date::Biorhythm - calculate biorhythms

=head1 SYNOPSIS

  use Date::Biorhythm

  Date::Biorhythm->birth (month => 5, day => 11, year => 1969); # my b'day!
  Date::Biorhythm->chart (month => 11, day => 23, year => 2001);
  Date::Biorhythm->chart (); # uses current time if no time given

  Birth Date:	19690511
  Chart Date:	20011123
  Difference:	11884 days

  you are at day 04 of 33 in your intellectual cycle
  you are at day 16 of 23 in your physical cycle
  you are at day 12 of 28 in your emotional cycle

=head1 DESCRIPTION

Biorhythms are the most general cycles that your body has. While other
cycles are easy to measure empirically (ie, circadian rhythms, rate of
cell replacement), biorhythms are more general. It's almost like the
difference between neurobiology and psychology.

=head1 General Facts About Biorhythms

=over 4

=item * Most vulnerable times within a cycle

According to Gittleson, are when one switches from negative phase to
positive *or* vice versa. These are called C<critical days>. He makes
an analogy to the fact that a lightbulb is most likely to burn out
when the light is switched from off to on or vice versa.


=back

=head2 EXPORT

None by default.


=head1 AUTHOR

T. M. Brannon, <tbone@cpan.org>

=head1 REFERENCES



=cut
