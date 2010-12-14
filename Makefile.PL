#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'OpenData-BR-WWW';
all_from 'lib/OpenData/BR/WWW.pm';

requires 'Catalyst::Runtime' => '5.80029';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'parent';
requires 'MooseX::Role::Parameterized';
requires 'Perl6::Junction';
requires 'Catalyst::Authentication::Store::DBIx::Class';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Unicode::Encoding';
requires 'Catalyst::Plugin::Static::Simple';
requires 'MooseX::RelatedClassRoles';
requires 'CatalystX::SimpleLogin';
requires 'FCGI';
requires 'FCGI::ProcManager';
requires 'Catalyst::Controller::reCAPTCHA';

requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
