#!/usr/bin/perl

use Date::Biorhythm;

my $bio = Date::Biorhythm->new({
  name     => 'Unix',
  birthday => Date::Calc::Object->new(0, 1970, 1, 1),
});

my $i = 0;
my $limit = 365;
$bio->day(Date::Calc::Object->today);
while ($i < $limit) {
  print $bio->value('emotional'), "\n";
  $bio->next;
  $i++;
}
