package OpenData::BR::WWW::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

OpenData::BR::WWW::Controller::Root - Root Controller for OpenData::BR::WWW

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut
sub base : Chained('/') : PathPart('') : CaptureArgs(0) {}

sub index :Path :Args(0) {
    my ($self, $c) = @_;
    $c->res->redirect('/sobre');
}

sub sobre : Chained('base'): Args(0) {}
sub contato : Chained('base'): Args(0) {}
sub aplicativos : Chained('base'): Args(0) {}
sub dados : Chained('base'): Args(0) {}
sub ideias : Chained('base'): Args(0) {}
sub login : Chained('base'): Args(0) {}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Thiago Rondon

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
