package OpenData::BR::WWW;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple
    Unicode::Encoding
    +CatalystX::SimpleLogin
    Authentication
    Session
    Session::Store::File
    Session::State::Cookie
    Static::Simple
/;

extends 'Catalyst';

our $VERSION = '0.01';
$VERSION = eval $VERSION;

# Configure the application.
#
# Note that settings in opendata_br_www.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'OpenData::BR::WWW',
    # Disable deprecated behavior needed by old applications
    #disable_component_resolution_regex_fallback => 1,
    encoding => 'UTF-8',
    'Controller::Login' => {
        traits => [qw/ Logout WithRedirect -RenderAsTTTemplate /]
    },
    'Plugin::Session' => {
        flash_to_stash => 1
    },

);

__PACKAGE__->config(namespace => '');

__PACKAGE__->config(
    'Plugin::Authentication' => {
        default => {
            credential => {
                class => 'Password',
                password_field => 'password',
                password_type => 'clear'
            },
            store => {
                class => 'DBIx::Class',
                user_model => 'DB::Users',
            },
        },
    },
);

__PACKAGE__->config->{recaptcha}->{pub_key} = '6LcNlb8SAAAAAMVDLEYpb8mRAkeNVScBTgzyw3il';

__PACKAGE__->config->{recaptcha}->{priv_key} = '6LcNlb8SAAAAABnmMBBsSogLmcAKxXBYekX79zk2';

# Start the application
__PACKAGE__->setup();


=head1 NAME

OpenData::BR::WWW - Catalyst based application

=head1 SYNOPSIS

    script/opendata_br_www_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<OpenData::BR::WWW::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Thiago Rondon

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
