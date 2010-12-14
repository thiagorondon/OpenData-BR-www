
package OpenData::BR::Schema::Result::Ideias;


use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table("ideias");
__PACKAGE__->load_components(qw/Core InflateColumn::DateTime/);

__PACKAGE__->add_columns(
  "id",
    {
        data_type => "INT",
        default_value => undef,
        size => 11,
    },
    "title",
    {
        data_type => "varchar",
        default_value => undef,
        size => 255
    },
    "tags",
    {
        data_type => "longtext",
        default_value => undef,
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
    "active",
    {
        data_type => 'bool',
        default => 1
    },
    "user_id",
    {
        data_type => 'integer',
        size => 11
    }
);

__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint( ['title'] );

__PACKAGE__->belongs_to(
    user => 'OpenData::BR::Schema::Result::Users' => 
        { 'foreign.id' => 'self.user_id' }
);

1;

