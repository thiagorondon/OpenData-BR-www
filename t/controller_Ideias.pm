use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'OpenData::BR::WWW' }
BEGIN { use_ok 'OpenData::BR::WWW::Controller::Ideias' }

ok( request('/ideias')->is_success, 'Request should succeed' );
done_testing();
