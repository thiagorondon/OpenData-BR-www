package OpenData::BR::WWW::Controller::Ideias;
use Moose;
use MooseX::MethodAttributes;
use Email::Valid;

use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub base : Chained('/base') PathPart('ideias') CaptureArgs(0) {}

sub base_required : Chained('/required') PathPart('ideias') CaptureArgs(0) {}

sub root : Chained('base') PathPart('') Args(0) {}

sub nova : Chained('base') Args(0) {
    my ($self, $c) = @_;
    
    $c->forward('handle_POST');

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
