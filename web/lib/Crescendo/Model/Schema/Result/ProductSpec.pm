package Crescendo::Model::Schema::Result::ProductSpec;

use 5.10.1;
use utf8;
use warnings FATAL => 'all';
use Moose;

extends 'DBIx::Class::Core';

__PACKAGE__->table('product_spec');

__PACKAGE__->add_columns(
    qw<
      product_spec_id
      product_id
      spec_id
      value
      >
);

__PACKAGE__->set_primary_key('product_spec_id');

__PACKAGE__->belongs_to(
    product => 'Crescendo::Model::Schema::Result::Product',
    { 'foreign.product_id' => 'self.product_id' }
);

__PACKAGE__->belongs_to(
    specification => 'Crescendo::Model::Schema::Result::Spec',
    { 'foreign.spec_id' => 'self.spec_id' }
);

no Moose;
__PACKAGE__->meta->make_immutable( inline_constructor => 0 );

1;
