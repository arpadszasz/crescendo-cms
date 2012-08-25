package Crescendo::Model::Schema::Result::Image;

use 5.10.1;
use utf8;
use warnings FATAL => 'all';
use Moose;

extends 'DBIx::Class::Core';


__PACKAGE__->table('image');

__PACKAGE__->add_columns(
    qw<
      image_id
      filename
      >
);

__PACKAGE__->set_primary_key('image_id');

no Moose;
__PACKAGE__->meta->make_immutable( inline_constructor => 0 );

1;
