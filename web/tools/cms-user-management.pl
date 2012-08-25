#!/usr/bin/env perl

use 5.10.1;
use utf8;
use warnings FATAL => 'all';

my $REALBIN;

BEGIN {
    use File::Basename 'dirname';
    use File::Spec::Functions 'rel2abs';
    $REALBIN = rel2abs( dirname(__FILE__) );
}

use lib "$REALBIN/../lib", "$REALBIN/../opt";
use IO::Prompter;
use File::Slurp 'slurp';
use JSON;
use App::Genpass;
use Crescendo::Model;

binmode( STDOUT, ':encoding(utf8)' );

my $cfg_file = $ARGV[0] || show_help();

my $model = Crescendo::Model->new(
    cfg => JSON->new->decode( scalar slurp $cfg_file ) );

say "Crescendo CMS Toolkit: User Management";
show_main_menu();


exit 0;


sub show_help {
    say "Usage: ./cms-user-management.pl configuration.cfg";
    exit 64;
}


sub show_main_menu {
    my $selection = prompt "\nSelect action:", -menu => [
        'Change CMS administrator password',
        'Add new user account',
        'Change user account',
        'Quit'
      ],
      '> ', '-number', '-stdio';

    given ($selection) {
        when (/administrator password/) { change_sysadmin_password() }
        when (/Add new user/)           { ... }
        when (/Change user/)            { show_accounts_menu() }
        when (/Quit/)                   { exit 0; }
    }
}


sub autogenerate_password {
    my $account_id = shift;
    my $username   = shift;

    my $password = App::Genpass->new( length => 64, readable => 0 )->generate;

    $model->account->change_password(
        { account_id => $account_id, password => $password } );

    if (
        $model->account->check(
            { username => $username, password => $password }
        )
      ) {
        say "Password changed to: $password";
    }
    else {
        say "Password change error!";
    }

    return;
}


sub change_sysadmin_password {
    autogenerate_password( 1, 'system.administrator' );
    show_main_menu();
}


sub show_accounts_menu {
    my @menu_options;
    my %account;
    foreach my $account ( @{ $model->account->list } ) {
        push(
            @menu_options,
            $account->username
        );
        $account{ $account->username } = $account->account_id;
    }
    push( @menu_options, 'Back' );

    my $selection = prompt "\nSelect user account:", -menu => \@menu_options,
      '> ', '-number', '-stdio';

    my $selected_account_id;
    my $selected_username;
    given ($selection) {
        when (/Back/) { show_main_menu() }
        default {
            ($selected_username) = $selection =~ m/^(.+)$/;
            $selected_account_id = $account{$selected_username};
        }
    }

    show_user_menu( $selected_account_id, $selected_username );
}


sub show_user_menu {
    my $account_id = shift;
    my $username   = shift;

    my $selection = prompt "\nSelect operation on $username account:",
      -menu => [
        'Change password',
        'Autogenerate password',
        'Back'
      ],
      '> ', '-number', '-stdio';

    given ($selection) {
        when (/Change password/) {
            my $password = prompt 'Enter password: ', -echo => '',
              '-stdio', '-verbatim';
            my $password_confirm = prompt 'Confirm password: ', -echo => '',
              '-stdio', '-verbatim';

            if ( $password eq $password_confirm ) {
                $model->account->change_password(
                    {
                        account_id => $account_id,
                        password   => $password
                    }
                );
                say "Password changed for user '$username'";
            }
            else {
                say "Passwords don't match!";
            }
        }
        when (/Autogenerate password/) {
            autogenerate_password( $account_id, $username );
        }
        when (/Back/) { show_accounts_menu() }
    }

    show_user_menu( $account_id, $username );
}
