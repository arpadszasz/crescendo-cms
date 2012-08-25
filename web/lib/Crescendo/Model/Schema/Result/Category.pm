package Crescendo::Model::Schema::Result::Category;

use 5.10.1;
use utf8;
use warnings FATAL => 'all';
use Moose;

extends 'DBIx::Class::Core';

__PACKAGE__->table('category');

__PACKAGE__->add_columns(
    qw<
      category_id
      name
      >
);

__PACKAGE__->set_primary_key('category_id');

no Moose;
__PACKAGE__->meta->make_immutable( inline_constructor => 0 );

1;
