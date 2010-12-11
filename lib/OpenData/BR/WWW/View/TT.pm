package OpenData::BR::WWW::View::TT;

use Moose;
BEGIN { extends 'Catalyst::View::TT' }

__PACKAGE__->config(
    INCLUDE_PATH => [
        OpenData::BR::WWW->path_to( 'root', 'src' ),
        OpenData::BR::WWW->path_to( 'root', 'lib' )
    ],
    TEMPLATE_EXTENSION => '.tt',
    ENCODING           => 'utf8',
    WRAPPER            => 'site/wrapper.tt',
    TIMER              => 0,
);

=head1 NAME

OpenData::BR::WWW::View::TT - TT View for SPPM::Web

=head1 DESCRIPTION

TT View for OpenData::BR::WWW.

=head1 SEE ALSO

L<SPPM::Web>

=head1 AUTHOR

Thiago Rondon,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
