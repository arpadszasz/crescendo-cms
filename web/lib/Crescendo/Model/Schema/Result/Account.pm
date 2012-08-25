package Crescendo::Model::Schema::Result::Account;

use 5.10.1;
use utf8;
use warnings FATAL => 'all';
use Moose;

extends 'DBIx::Class::Core';

__PACKAGE__->load_components(q<PassphraseColumn InflateColumn::DateTime>);

__PACKAGE__->table('account');

__PACKAGE__->add_columns(
    qw<
      account_id
      username
      >,
    password => {
        data_type        => 'text',
        passphrase       => 'crypt',
        passphrase_class => 'BlowfishCrypt',
        passphrase_args  => {
            cost        => 12,
            salt_random => 1,
        },
        passphrase_check_method => 'check_password',
    },
);

__PACKAGE__->set_primary_key('account_id');

no Moose;
__PACKAGE__->meta->make_immutable( inline_constructor => 0 );

1;
