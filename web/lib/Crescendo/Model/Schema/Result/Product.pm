package Crescendo::Model::Schema::Result::Product;

use 5.10.1;
use utf8;
use warnings FATAL => 'all';
use Moose;

extends 'DBIx::Class::Core';

__PACKAGE__->table('product');

__PACKAGE__->add_columns(
    qw<
      product_id
      name
      code
      description
      price
      discount_price
      >
);

__PACKAGE__->set_primary_key('product_id');

__PACKAGE__->has_many(
    specification => 'Crescendo::Model::Schema::Result::ProductSpec',
    { 'foreign.product_id' => 'self.product_id' }
);

no Moose;
__PACKAGE__->meta->make_immutable( inline_constructor => 0 );

1;
