package Crescendo::Web;

use 5.10.1;
use strict;
use utf8;
use warnings FATAL => 'all';
use Moose;

extends 'Mojolicious';

sub startup {
    my $self = shift;

    $self->log->level('error');
    $self->plugin( charset => { charset => 'UTF-8' } );
    $self->plugin('default_helpers');

    my $r = $self->routes;
    $r->route('/')->to('main#index')->name('main/index');

    return;
}

1;
