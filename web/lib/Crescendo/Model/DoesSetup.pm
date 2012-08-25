package Crescendo::Model::DoesSetup;

use 5.10.1;
use utf8;
use warnings FATAL => 'all';
use Moose::Role;

has 'dbh' => (
    isa => 'Object',
    is  => 'rw'
);

1;
