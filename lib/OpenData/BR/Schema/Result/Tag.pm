package OpenData::BR::Schema::Result::Tag;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table("tag");
__PACKAGE__->load_components(qw/Core ForceUTF8/);

__PACKAGE__->add_columns(
    "id",
    {
        data_type => "INT",
        size => 11,
        is_nullable => 0,
        is_auto_increment => 1,
    },
    "tag",
    {
        data_type => "varchar",
        size => 255
    },
);

__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint( ['tag'] );

1;

