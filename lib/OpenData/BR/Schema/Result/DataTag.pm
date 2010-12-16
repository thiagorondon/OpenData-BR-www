package OpenData::BR::Schema::Result::DataTag;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table("data_tag");
__PACKAGE__->load_components(qw/Core ForceUTF8/);

__PACKAGE__->add_columns(
    "data_id",
    {
        data_type => "INT",
        size => 11,
        is_nullable => 0,
        is_auto_increment => 1,
    },
    "tag_id",
    {
        data_type => "INT",
        size => 255
    },
);

__PACKAGE__->set_primary_key(qw(data_id tag_id));

__PACKAGE__->belongs_to(
    data => 'OpenData::BR::Schema::Result::Data' =>
        { 'foreign.id' => 'self.data_id' } );

__PACKAGE__->belongs_to(
    tag => 'OpenData::BR::Schema::Result::Tag' =>
        { 'foreign.id' => 'self.tag_id' } );

1;

