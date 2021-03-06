package OpenData::BR::WWW::Controller::Dados;
use Moose;
use MooseX::MethodAttributes;
use Email::Valid;

use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub base : Chained('/base') PathPart('dados') CaptureArgs(0) {}

sub base_required : Chained('/required') PathPart('dados') CaptureArgs(0) {}

sub root : Chained('base') PathPart('') Args(0) {
    my ($self, $c) = @_;

    $c->forward('last_DADOS');
}

sub ver : Chained('base') Args(1) {
    my ($self, $c, $id) = @_;
    my $collection = $c->model('DB::Data');

    $c->stash->{dado} = $collection->find($id);
    $c->forward('handle_POST');

    if (length($c->req->param('descricao')) < 10) {
        $c->stash->{error_msg} = "Comentario muito curto.";
        $c->stash->{descricao} = $c->req->param('descricao');
        $c->detach;
    }

    my $collection_comments = $c->model('DB::DataComment');
    $collection_comments->new({
        user_id => $c->user->obj->id,
        data_id => $id,
        description => $c->req->param('descricao'),
        create_time => \'NOW()',
        url => $c->req->param('url')
    })->insert;
    
    $c->stash->{dado} = $collection->find($id);
    $c->stash->{success} = 1;
}

sub nova : Chained('base_required') Args(0) {
    my ($self, $c) = @_;
    
    $c->forward('handle_POST');
    $c->forward('check_DATA');

    $c->stash->{dado} = $c->model('DB::Data')->new({
        title => $c->req->param('titulo'),
        description => $c->req->param('descricao'),
        user_id => $c->user->obj->id,
        create_time => \'NOW()',
        active => 0
    })->insert;

    if ($c->stash->{dado}->id) {
        $c->forward('create_TAGS');
        $c->stash->{success} = 1;
    } else {
        $c->stash->{error_msg} = 1;
    }
}

sub create_TAGS : Private {
    my ($self, $c) = @_;

    foreach my $tag (split(',', $c->req->param('tags'))) {
        chomp($tag);
        $tag =~ s/^ *//;
        $tag =~ s/ *$//;
        
        my $obj = $c->model('DB::Tag')->find_or_create({ name => $tag });
        $c->model('DB::DataTag')->find_or_create({ 
            tag_id => $obj->id, 
            data_id => $c->stash->{dado}->id
        });
    }
}

sub last_DADOS : Private {
    my ($self, $c) = @_;
    my $collection = $c->model('DB::Data');

    $c->stash->{collection}{dados} = $collection->search({});

}

sub check_DATA : Private {
    my ($self, $c) = @_;
    my $collection = $c->model('DB::Data');

    my @error_fields = ();
    if ( !$c->req->param('titulo') or length($c->req->param('titulo')) < 8 ) {
        $c->stash->{error_msg} = "O Titulo deve ter no minimo 8 caracteres.";
        push(@error_fields, 1);
    }

    if ( $collection->find({ title => $c->req->param('titulo') }) ) {
        $c->stash->{error_msg} = "Ja existe um dado  com este titulo";
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

    if (!$c->req->param('url')) {
        $c->stash->{error_msg} = "URL invalida";
        push(@error_fields, 'url');
    }

    my @fields = ('titulo', 'tags', 'descricao', 'url');
    map { $c->stash->{$_} = $c->req->param($_) } @fields;
    map { $c->stash->{$_} = undef } @error_fields;
    $c->detach if scalar(@error_fields);

}

sub handle_POST : Private {
    my ($self, $c) = @_;

    $c->detach if $c->req->method eq 'GET';
}

=head1 NAME

OpenData::BR::WWW::Controller::Dados - Catalyst Controller

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
