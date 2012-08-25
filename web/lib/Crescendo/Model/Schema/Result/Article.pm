package Crescendo::Model::Schema::Result::Article;

use 5.10.1;
use utf8;
use warnings FATAL => 'all';
use Moose;

extends 'DBIx::Class::Core';


__PACKAGE__->table('article');

__PACKAGE__->add_columns(
    qw<
      article_id
      title
      content
      >
);

__PACKAGE__->set_primary_key('article_id');


no Moose;
__PACKAGE__->meta->make_immutable( inline_constructor => 0 );

1;
