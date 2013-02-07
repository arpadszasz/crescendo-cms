#!/usr/bin/env perl

use 5.10.1;
use strict;
use utf8;
use warnings FATAL => 'all';

our $RealBin;

BEGIN {
    use File::Basename 'dirname';
    use File::Spec::Functions 'rel2abs';
    $RealBin = rel2abs( dirname(__FILE__) );

    if ( !defined $ENV{MOJO_MODE} ) {
        $ENV{MOJO_MODE} = 'production';
    }

    $ENV{MOJO_HOME} = "$RealBin/..";
}

use lib ("$RealBin/../lib");
use Crescendo::Web;

my $app = Crescendo::Web->new;
$app->start();
