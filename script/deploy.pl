#!/usr/bin/perl

use FindBin qw($Bin);
use lib "$Bin/../lib";

use aliased 'OpenData::BR::Schema';
use aliased 'DBIx::Class::DeploymentHandler' => 'DH';

my $dh = DH->new({
    schema => Schema->connect('dbi:mysql:dbname=opendatabr_org', 'thiago', ''),
    sql_translator_args => { add_drop_table => 1 },
});

$dh->prepare_install;

$dh->install;

