
package OpenData::BR::Schema::Result::IdeiaTag;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table("ideia_tag");
__PACKAGE__->load_components(qw/Core ForceUTF8/);

__PACKAGE__->add_columns(
    "ideia_id",
    {
        data_type => "INT",
        size => 11,
    },
    "tag_id",
    {
        data_type => "INT",
        size => 255
    },
);

__PACKAGE__->set_primary_key(qw(ideia_id tag_id));

__PACKAGE__->belongs_to(
    ideia => 'OpenData::BR::Schema::Result::Ideia' =>
        { 'foreign.id' => 'self.ideia_id' } );

__PACKAGE__->belongs_to(
    tag => 'OpenData::BR::Schema::Result::Tag' =>
        { 'foreign.id' => 'self.tag_id' } );

1;

