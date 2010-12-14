
package OpenData::BR::Schema::Result::IdeiasComments;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table("ideias_comments");
__PACKAGE__->load_components(qw/Core InflateColumn::DateTime/);

__PACKAGE__->add_columns(
    "id",
    {
        data_type => "INT",
        default_value => undef,
        size => 11,
    },
    "user_id",
    {
        data_type => "INT",
        default_value => undef
    },
    "ideia_id",
    {
        data_type => "INT",
        default_value => undef
    },
    "description",
    {
        data_type => "longtext",
    },
    "create_time",
    {
        data_type => "timestamp",
        size => 4,
        default => \'NOW()',
    },
);

__PACKAGE__->set_primary_key("id");

__PACKAGE__->belongs_to(
    user => 'OpenData::BR::Schema::Result::Users' => 
        { 'foreign.id' => 'self.user_id' }
);

__PACKAGE__->belongs_to(
    ideia => 'OpenData::BR::Schema::Result::Ideias' => 
        { 'foreign.id' => 'self.ideia_id' }
);

1;

