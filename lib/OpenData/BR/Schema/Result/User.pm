package OpenData::BR::Schema::Result::User;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table("user");
__PACKAGE__->load_components(qw/Core InflateColumn::DateTime ForceUTF8/);

__PACKAGE__->add_columns(
  "id",
    {
        data_type => "INT",
        size => 11,
        is_nullable => 0,
        is_auto_increment => 1,
    },
    "name",
    {
        data_type => "varchar",
        default_value => undef,
        size => 255
    },
    "username",
    {
        data_type => "varchar",
        default_value => undef,
        szie => 255,
    },
    "create_time",
    {
        data_type => "timestamp",
        size => 4,
        default => \'NOW()',
    },
    "password",
    {
        data_type => "varchar",
        size => 255,
    },
    "active",
    {
        data_type => 'bool',
        default => 1
    },
);

__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint( ['username'] );

__PACKAGE__->has_many(
    ideias => 'OpenData::BR::Schema::Result::Ideia'
        => { 'foreign.user_id' => 'self.id' }
);

1;

