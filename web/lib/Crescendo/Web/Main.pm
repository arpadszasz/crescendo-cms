package Crescendo::Web::Main;

use 5.10.1;
use strict;
use utf8;
use warnings FATAL => 'all';
use Moose;

extends 'Mojolicious::Controller';

sub index {
    my $self = shift;
    return $self->render('main/index');
}

1;
