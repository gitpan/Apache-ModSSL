package TestSSL::lookup;

use strict;
use warnings FATAL => 'all';

use Apache::RequestRec ();
use Apache::RequestUtil ();
use Apache::RequestIO ();
use Apache::ModSSL ();

use Apache::Const -compile => qw(OK DECLINED);

sub handler {
  my $r = shift;

  $r->content_type('text/plain');
  my $rc=$r->connection->ssl_var_lookup($r->args);
  $rc="UNDEF" unless( defined $rc );
  $r->print($rc."\n");

  Apache::OK;
}

1;
