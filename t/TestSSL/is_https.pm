package TestSSL::is_https;

use strict;
use warnings FATAL => 'all';
no warnings 'uninitialized';

use Apache::RequestRec ();
use Apache::RequestUtil ();
use Apache::RequestIO ();
use Apache::ModSSL ();

use Apache::Const -compile => qw(OK DECLINED);

sub handler {
  my $r = shift;

  $r->content_type('text/plain');
  my $is_https=$r->connection->is_https;
  $is_https="UNDEF" unless( defined $is_https );
  $r->print('HAVE_SSL='.$r->dir_config('HAVE_SSL').' is_https: '.$is_https."\n");

  Apache::OK;
}

1;
