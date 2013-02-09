package Crescendo::Web::Admin::Setup;

use 5.10.1;
use strict;
use utf8;
use warnings FATAL => 'all';
use Moose;
use DBI;
use Config::INI::Writer;
use DBIx::MultiStatementDo;

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
                name     => 'crescendo_cms',
                username => $self->param('db_user'),
                password => $self->param('db_password'),
            }
        },
        $self->app->home . '/etc/config.ini',
    );

    my $db_schema_file
      = $self->app->home . '/db/schema-' . $self->param('db_type') . '.sql';
    open( my $db_schema_fh, '<', $db_schema_file )
      or die qq/Can't open schema file $db_schema_file/;
    my $sql = do { local $/; <$db_schema_fh> };
    close $db_schema_fh;

    my $dbh = DBI->connect(
        "dbi:" . $self->param('db_type') . ":dbname=crescendo_cms",
        $self->param('db_user'),
        $self->param('db_password'),
    );

    my $batch = DBIx::MultiStatementDo->new( dbh => $dbh );
    $batch->do($sql) or die $batch->dbh->errstr;

    return $self->redirect_to('/admin/setup/step-2');
}

sub step_2 {
    my $self = shift;
    return $self->render('admin/setup/step-2');
}

1;
