#include <modules/perl/mod_perl.h>

/* mod_ssl.h is not safe for inclusion in 2.0, so duplicate the
 * optional function declarations. */
APR_DECLARE_OPTIONAL_FN(char *, ssl_var_lookup,
                        (apr_pool_t *, server_rec *,
                         conn_rec *, request_rec *,
                         char *));
APR_DECLARE_OPTIONAL_FN(int, ssl_is_https, (conn_rec *));

typedef conn_rec *Apache__Connection;
typedef request_rec *Apache__Request;

static APR_OPTIONAL_FN_TYPE(ssl_var_lookup) *lookup = NULL;
static APR_OPTIONAL_FN_TYPE(ssl_is_https) *is_https = NULL;

MODULE = Apache::ModSSL    PACKAGE = Apache::Connection   PREFIX = mpxs_Apache__Connection_

int
mpxs_Apache__Connection_is_https(c)
    Apache::Connection c
PROTOTYPE: $
CODE:
  {
    if( !is_https ) return XSRETURN_UNDEF;
    RETVAL=is_https(c);
  }
OUTPUT:
    RETVAL

void
mpxs_Apache__Connection_ssl_var_lookup(c, var)
    Apache::Connection c
    char *var
PROTOTYPE: $$
PPCODE:
  {
    if( !lookup ) return XSRETURN_UNDEF;
    PUSHs(sv_2mortal(newSVpv(lookup( NULL, c->base_server, c, NULL, var ), 0)));
  }

MODULE = Apache::ModSSL

BOOT:
    lookup=APR_RETRIEVE_OPTIONAL_FN(ssl_var_lookup);
    is_https=APR_RETRIEVE_OPTIONAL_FN(ssl_is_https);
    items = items; /* -Wall */

## Local Variables: ##
## mode: c ##
## End: ##
