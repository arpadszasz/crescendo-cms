package Crescendo::Model;

use 5.10.1;
use utf8;
use warnings FATAL => 'all';
use Moose;
use Crescendo::Model::Schema;

use Crescendo::Model::Account;

has cfg => ( is => 'rw' );
has dbh => ( is => 'rw' );

sub BUILD {
    my $self = shift;
    my $args = shift;

    my $dsn
      = 'dbi:Pg:dbname='
      . $self->cfg->{db_name} . ';' . 'host='
      . $self->cfg->{db_host} . ';' . 'port='
      . $self->cfg->{db_port};

    my %dbi_args = (
        AutoCommit     => 1,
        RaiseError     => 1,
        pg_enable_utf8 => 1
    );

    my $app_name = $self->cfg->{app_name} || 'crescendo-cms';
    my %dbic_args = (
        on_connect_do => qq<
            SET application_name TO '$app_name';
            SET NAMES 'UTF-8';
            SET TIMEZONE TO 'UTC';
        >
    );

    $self->dbh(
        Crescendo::Model::Schema->connect(
            $dsn,
            $self->cfg->{db_user},
            $self->cfg->{db_pass},
            \%dbi_args,
            \%dbic_args
        )
    );

    $self->dbh->storage->sql_maker->quote_char('"');

    return;
}


sub account {
    my $self = shift;
    return Crescendo::Model::Account->new( { dbh => $self->dbh } );
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
