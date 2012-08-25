package Crescendo::Model::Schema;

use 5.10.1;
use utf8;
use warnings FATAL => 'all';
use Moose;

extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;

no Moose;
__PACKAGE__->meta->make_immutable;

1;
