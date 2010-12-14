package OpenData::BR::WWW::Controller::Ideias;
use Moose;
use MooseX::MethodAttributes;
use Email::Valid;

use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub base : Chained('/base') PathPart('ideias') CaptureArgs(0) {}

sub base_required : Chained('/required') PathPart('ideias') CaptureArgs(0) {}

sub root : Chained('base') PathPart('') Args(0) {
    my ($self, $c) = @_;

    $c->forward('last_IDEIAS');
}

sub ver : Chained('base') Args(1) {
    my ($self, $c, $id) = @_;
    my $collection = $c->model('DB::Ideias');

    $c->stash->{ideia} = $collection->find($id);
}

sub nova : Chained('base_required') Args(0) {
    my ($self, $c) = @_;
    
    $c->forward('handle_POST');
    $c->forward('check_DATA');

    my $collection = $c->model('DB::Ideias');

    $collection->new({
        title => $c->req->param('titulo'),
        description => $c->req->param('descricao'),
        tags => $c->req->param('tags'),
        user_id => $c->user->obj->id,
        create_time => \'NOW()',
        active => 0
    })->insert;

    $c->stash->{success} = 1;
}

sub last_IDEIAS : Private {
    my ($self, $c) = @_;
    my $collection = $c->model('DB::Ideias');

    $c->stash->{collection}{ideias} = $collection->search({});

}

sub check_DATA : Private {
    my ($self, $c) = @_;
    my $collection = $c->model('DB::Ideias');

    my @error_fields = ();
    if ( !$c->req->param('titulo') or length($c->req->param('titulo')) < 8 ) {
        $c->stash->{error_msg} = "O Titulo deve ter no minimo 8 caracteres.";
        push(@error_fields, 1);
    }

    if ( $collection->find({ title => $c->req->param('titulo') }) ) {
        $c->stash->{error_msg} = "Ja existe uma ideia com este titulo";
        push(@error_fields, 1);
    }

    if ( ! $c->req->param('tags') ) {
        $c->stash->{error_msg} = "É obrigatorio no minimo uma tag.";
        push(@error_fields, 'tags');
    }

    my @tags = split( ',', $c->req->param('tags') );
    my $tag_error = 0;
    foreach my $item (@tags) {
        warn $item and $tag_error++ unless $item =~ /^[a-zA-Z0-9\ ]*$/;
    }

    if ($tag_error) {
        $c->stash->{error_msg} = "Caracter invalido no campo tags";
        push(@error_fields, 1);
    }

    if (!$c->req->param('descricao')) {
        $c->stash->{error_msg} = "Descricao invalida";
        push(@error_fields, 'descricao');
    }

    my @fields = ('titulo', 'tags', 'descricao');
    map { $c->stash->{$_} = $c->req->param($_) } @fields;
    map { $c->stash->{$_} = undef } @error_fields;
    $c->detach if scalar(@error_fields);

}

sub handle_POST : Private {
    my ($self, $c) = @_;

    $c->detach if $c->req->method eq 'GET';
}

=head1 NAME

OpenData::BR::WWW::Controller::Ideias - Catalyst Controller

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
