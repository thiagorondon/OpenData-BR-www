package OpenData::BR::Schema::Result::DataFile;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table("data_file");
__PACKAGE__->load_components(qw/Core InflateColumn::DateTime ForceUTF8/);

__PACKAGE__->add_columns(
    "id",
    {
        data_type => "INT",
        size => 11,
        is_nullable => 0,
        is_auto_increment => 1,
    },
    "user_id",
    {
        data_type => "INT",
        default_value => undef
    },
    "data_id",
    {
        data_type => "INT",
        default_value => undef
    },
    "title",
    {
        data_type => "varchar",
        size => 255
    },
    "format",
    {
        data_type => "char",
        size => 11
    },
    "fspath",
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
    user => 'OpenData::BR::Schema::Result::User' => 
        { 'foreign.id' => 'self.user_id' }
);

__PACKAGE__->belongs_to(
    data => 'OpenData::BR::Schema::Result::Data' => 
        { 'foreign.id' => 'self.data_id' }
);

1;

