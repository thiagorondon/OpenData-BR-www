package OpenData::BR::WWW::Controller::User;
use Moose;
use MooseX::MethodAttributes;
use Email::Valid;

use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub base : Chained('/base') PathPart('usuario') CaptureArgs(0) {}

sub base_required : Chained('/required') PathPart('usuario') CaptureArgs(0) {}

sub cadastro : Chained('base') Args(0) {
    my ($self, $c) = @_;
    my $collection = $c->model('DB::Users');
    
    $c->forward('handle_POST');
    $c->forward('check_DATA');

    $collection->new({
        name => $c->req->param('nome'),
        password => $c->req->param('senha'),
        username => $c->req->param('email'),
        active => 1
    })->insert;

    $c->stash->{success} = 1;
}

sub preferencias : Chained('base_required') : Args(0) {
    my ($self, $c) = @_;

    my $collection = $c->model('DB::Users');
    my $obj = $collection->find($c->user->obj->id);
    
    $c->stash->{nome} = $obj->name;
    $c->stash->{preferencias} = 1;

    $c->forward('handle_POST');
    $c->forward('check_DATA');

    $obj->update({
        name => $c->req->param('nome'),
        $c->req->param('senha') ? ( password => $c->req->param('senha') ) : ()
    });

    $c->stash->{nome} = $obj->name;
    $c->stash->{success} = 1;
}

sub check_DATA : Private {
    my ($self, $c) = @_;

    if (length($c->req->param('nome')) < 10) {
        $c->stash->{error_msg} = 'Nome muito curto.';
        $c->detach;
    }

    my $need_to_check_pass = 0;
    if ( ($c->stash->{preferencias} and $c->req->param('senha') ) 
            or !$c->stash->{preferencias} ) {
        $need_to_check_pass = 1;
    }
    
    if ( $need_to_check_pass and length($c->req->param('senha')) < 5 ) {
        $c->stash->{error_msg} = 'A senha deve conter no minimo 5 caracteres';
        $c->detach;
    }

    if ( !$c->stash->{preferencias} and 
            !Email::Valid->address($c->req->param('email')) ) {
        $c->stash->{error_msg} = 'E-mail invalido';
        $c->detach;
    }
}
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
