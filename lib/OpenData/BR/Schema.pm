
package OpenData::BR::Schema;
use base qw/DBIx::Class::Schema/;

our $VERSION = 0.001;

__PACKAGE__->load_namespaces();

__PACKAGE__->load_components(qw/Schema::Versioned/);

1;


