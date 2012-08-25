package Crescendo::Model::Account;

use 5.10.1;
use utf8;
use warnings FATAL => 'all';
use Moose;

with 'Crescendo::Model::DoesSetup';

sub change_password {
    my $self = shift;
    my $args = shift;

    $self->dbh->resultset('Account')
      ->search( { account_id => $args->{account_id} } )
      ->single->update( { password => $args->{password} } );

    return;
}

sub check {
    my $self = shift;
    my $args = shift;

    my $rs = $self->dbh->resultset('Account')
      ->find( { username => $args->{username} } );

    return unless $rs;

    if ( $rs->check_password( $args->{password} ) ) {
        return {
            account_id => $rs->account_id,
            username   => $rs->username,
        };
    }

    return;
}

sub list {
    my $self = shift;

    my $rs = $self->dbh->resultset('Account')
      ->search( { account_id => { '>' => 1 } } );

    my @accounts;
    while ( my $account = $rs->next ) {
        push( @accounts, $account );
    }

    return \@accounts;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
