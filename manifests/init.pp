# Class: users
#
#   This module configures user environments and manages users.
#
#   Adrian Webb <adrian.webb@coraltg.com>
#   2012-05-22
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters:
#
#   $user_names  = [ ]
#   $user_groups = [ ]
#   $key         = ''
#   $email       = ''
#   $editor      = 'vim'
#   $umask       = 002
#   $init        = false
#
# Actions:
#
#   Configures user environments and manages users
#
# Requires:
#
# Sample Usage:
#
#   class { 'users':
#     user_names  => [ 'admin' ],
#     user_groups => [ 'admin' ],
#     key         => '<SOME PUBLIC SSH KEY>',
#     email       => 'admin@example.com',
#     editor      => 'vim',
#     umask       => 002,
#     init        => true,
#  }
#
# [Remember: No empty lines between comments and class definition]
class users (
  $user_names  = [ ],
  $user_groups = [ ],
  $key         = '',
  $email       = '',
  $editor      = 'vim',
  $umask       = 002,
  $init        = false,
) {

  include users::params

  #-----------------------------------------------------------------------------

  if $init and $users::params::vim_version {
    package {
      'vim':
        ensure => $users::params::vim_version;
    }
  }

  #-----------------------------------------------------------------------------
  # Root user profile information

  if $init and $users::params::root_home {
    file {
      "${users::params::root_home}/.profile":
        owner   => 'root',
        group   => 'root',
        mode    => 640,
        content => template('users/root/.profile.erb');

      "${users::params::root_home}/.bashrc":
        owner   => 'root',
        group   => 'root',
        mode    => 640,
        content => template('users/root/.bashrc.erb');

      "${users::params::root_home}/.bash_aliases":
        owner  => 'root',
        group  => 'root',
        mode   => 640,
        source => 'puppet:///modules/users/.bash_aliases';
    }
  }

  #-----------------------------------------------------------------------------
  # Normal user profile information

  if $init and $users::params::skel_home {
    file {
      "${users::params::skel_home}/.profile":
        owner   => "root",
        group   => "root",
        mode    => 640,
        content => template('users/skel/.profile.erb');

      "${users::params::skel_home}/.bashrc":
        owner    => 'root',
        group    => 'root',
        mode     => 640,
        content  => template('users/skel/.bashrc.erb');

      "${users::params::skel_home}/.bash_aliases":
        owner  => 'root',
        group  => 'root',
        mode   => 640,
        source => 'puppet:///modules/users/.bash_aliases';
    }
  }

  #-----------------------------------------------------------------------------

  if $user_names and $key {
    users::user { $user_names:
      groups  => $user_groups,
      key     => "${key} ${email}",
    }
  }
}
