use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Date::Biorhythm',
    'VERSION_FROM'	=> 'lib/Date/Biorhythm.pm', # finds $VERSION
    'PREREQ_PM'		=> {
      Date::Business => 1.2
    }, # e.g., Module::Name => 1.1
);
