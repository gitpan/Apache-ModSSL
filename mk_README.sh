#!/bin/bash

(perldoc -tU ./lib/Apache::ModSSL.pm
 perldoc -tU $0
) >README

exit 0

=head1 INSTALLATION

 perl Makefile.PL
 make
 make test
 make install

=head1 DEPENDENCIES

mod_perl 1.99,
httpd 2.0.52,
perl 5.8.0

=cut