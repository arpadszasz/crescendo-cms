package Crescendo::Web::Admin::Setup;

use 5.10.1;
use strict;
use utf8;
use warnings FATAL => 'all';
use Moose;
use Config::INI::Writer;

extends 'Mojolicious::Controller';

sub step_1 {
    my $self = shift;
    return $self->render('admin/setup/step-1');
}

sub do_step_1 {
    my $self = shift;

    my %db_port = (
        mysql => 3306,
    );

    my $cfg_data = Config::INI::Writer->write_file(
        {
            db => {
                type     => $self->param('db_type'),
                host     => $self->param('db_host'),
                port     => $db_port{ $self->param('db_type') },
                name     => 'crescendo',
                username => $self->param('db_user'),
                password => $self->param('db_password'),
            }
        },
        $self->app->home . '/etc/config.ini',
    );

    return $self->redirect_to('/admin/setup/step-2');
}

sub step_2 {
    my $self = shift;
    return $self->render('admin/setup/step-2');
}

1;
