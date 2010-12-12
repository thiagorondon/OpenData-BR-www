package OpenData::BR::WWW::Controller::Usuario;
use Moose;
use MooseX::MethodAttributes;
use Email::Valid;

use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub base : Chained('/base') PathPart('usuario') CaptureArgs(0) {}

sub base_required : Chained('/required') PathPart('usuario') CaptureArgs(0) {}

sub cadastro : Chained('base') Args(0) {
    my ($self, $c) = @_;
    my $collection = $c->model('DB::Usuarios');
    
    $c->forward('handle_POST');

    if (length($c->req->param('nome')) < 10) {
        $c->stash->{error_msg} = 'Nome muito curto.';
        $c->detach;
    }

    if (length($c->req->param('senha')) < 5) {
        $c->stash->{error_msg} = 'A senha deve conter no minimo 5 caracteres';
        $c->detach;
    }

    if (!Email::Valid->address($c->req->param('email'))) {
        $c->stash->{error_msg} = 'E-mail invalido';
        $c->detach;
    }

    $collection->new({
        nome => $c->req->param('nome'),
        senha => $c->req->param('senha'),
        email => $c->req->param('email'),
        ativo => 1
    })->insert;

    $c->stash->{success} = 1;
}

sub preferencias : Chained('base_required') : Args(0) {}

sub handle_POST : Private {
    my ($self, $c) = @_;

    $c->detach if $c->req->method eq 'GET';
}

=head1 NAME

OpenData::BR::WWW::Controller::Usuario - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head1 AUTHOR

Thiago Rondon

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
