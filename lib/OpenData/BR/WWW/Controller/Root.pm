package OpenData::BR::WWW::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config->{namespace} = '';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#

=head1 NAME

OpenData::BR::WWW::Controller::Root - Root Controller for OpenData::BR::WWW

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub base : Chained('/') : PathPart('') : CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash->{user} = $c->user if defined($c->user);
}

sub required : Chained('/login/required') PathPart('') : CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash->{user} = $c->user;
}

sub index :Path :Args(0) {
    my ($self, $c) = @_;
    $c->stash->{user} = $c->user;
    $c->stash->{collection}{ideia} = $c->model('DB::Ideia');
    $c->stash->{collection}{user} = $c->model('DB::User');
}

sub sobre : Chained('/base'): Args(0) {}
sub comunidade : Chained('/base'): Args(0) {}
sub aplicativos : Chained('/base'): Args(0) {}
sub faq : Chained('/base'): Args(0) {}
sub especificacao : Chained('/base') : Args(0) {}
sub visualizacao : Chained('/base') : Args(0) {}

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
