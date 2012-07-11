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
#  $editor               = $users::params::editor,
#  $umask                = $users::params::umask,
#  $root_home            = $users::params::root_home,
#  $skel_home            = $users::params::skel_home,
#  $root_public_ssh_key  = $users::params::root_public_ssh_key,
#  $root_private_ssh_key = $users::params::root_private_ssh_key,
#  $root_ssh_key_type    = $users::params::root_ssh_key_type,
#
# Actions:
#
#   Configures user environments and manages users.
#
#   Provides the users::add_user() definition.
#
# Requires:
#
# Sample Usage:
#
#   class { 'users':
#     editor => 'vim',
#     umask  => 002,
#  }
#
# [Remember: No empty lines between comments and class definition]
class users (

  $editor               = $users::params::editor,
  $umask                = $users::params::umask,
  $root_home            = $users::params::root_home,
  $skel_home            = $users::params::skel_home,
  $root_public_ssh_key  = $users::params::root_public_ssh_key,
  $root_private_ssh_key = $users::params::root_private_ssh_key,
  $root_ssh_key_type    = $users::params::root_ssh_key_type,

) inherits users::params {

  $root_ssh_path = "${root_home}/.ssh"

  #-----------------------------------------------------------------------------
  # Root user information

  if $root_home {
    file {
      "${root_home}/.profile":
        owner   => 'root',
        group   => 'root',
        mode    => 640,
        content => template('users/root/.profile.erb');

      "${root_home}/.bashrc":
        owner   => 'root',
        group   => 'root',
        mode    => 640,
        content => template('users/root/.bashrc.erb');

      "${root_home}/.bash_aliases":
        owner  => 'root',
        group  => 'root',
        mode   => 640,
        source => 'puppet:///modules/users/.bash_aliases';
    }

    file { $root_ssh_path:
      ensure  => 'directory',
      owner   => 'root',
      group   => 'root',
      mode    => '700',
    }

    if $root_public_ssh_key {
      file { "${root_ssh_path}/id_${root_ssh_key_type}.pub":
        owner   => 'root',
        group   => 'root',
        mode    => 644,
        content => $root_public_ssh_key,
        require => File[$root_ssh_path],
      }
    }

    if $root_private_ssh_key {
      file { "${root_ssh_path}/id_${root_ssh_key_type}":
        owner   => 'root',
        group   => 'root',
        mode    => 600,
        content => $root_private_ssh_key,
        require => File[$root_ssh_path],
      }
    }
  }

  #-----------------------------------------------------------------------------
  # Normal user profile information

  if $skel_home {
    file {
      "${skel_home}/.profile":
        owner   => "root",
        group   => "root",
        mode    => 640,
        content => template('users/skel/.profile.erb');

      "${skel_home}/.bashrc":
        owner    => 'root',
        group    => 'root',
        mode     => 640,
        content  => template('users/skel/.bashrc.erb');

      "${skel_home}/.bash_aliases":
        owner  => 'root',
        group  => 'root',
        mode   => 640,
        source => 'puppet:///modules/users/.bash_aliases';
    }
  }
}
