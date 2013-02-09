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

    $r->route('/admin/setup/step-1')->to('admin-setup#step_1');
    $r->route('/admin/setup/do-step-1')->via('post')
      ->to('admin-setup#do_step_1');
    $r->route('/admin/setup/step-2')->to('admin-setup#step_2');

    return;
}

1;
