package OpenData::BR::Schema::Result::Ideia;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table("ideia");
__PACKAGE__->load_components(qw/Core InflateColumn::DateTime ForceUTF8/);

__PACKAGE__->add_columns(
  "id",
    {
        data_type => "INT",
        size => 11,
        is_nullable => 0,
        is_auto_increment => 1,
    },
    "title",
    {
        data_type => "varchar",
        default_value => undef,
        size => 255
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
    user => 'OpenData::BR::Schema::Result::User' => 
        { 'foreign.id' => 'self.user_id' }
);

__PACKAGE__->has_many(
    comments => 'OpenData::BR::Schema::Result::IdeiaComment'
        => { 'foreign.ideia_id' => 'self.id' }
);

__PACKAGE__->has_many(
    tags => 'OpenData::BR::Schema::Result::IdeiaTag'
        => { 'foreign.ideia_id' => 'self.id' }
);


1;

