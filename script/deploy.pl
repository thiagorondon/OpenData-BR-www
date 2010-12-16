#!/usr/bin/perl

use FindBin qw($Bin);
use lib "$Bin/../lib";

use aliased 'OpenData::BR::Schema';

my $schema = Schema->connect('dbi:mysql:dbname=opendatabr_org', 'thiago', '');

if (!$schema->get_db_version()) {
    # schema is unversioned
    $schema->deploy();
} else {
    $schema->upgrade();
}

