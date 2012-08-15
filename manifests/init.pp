# Class: users
#
#   This module configures user environments and manages users.
#
#   Adrian Webb <adrian.webb@coraltech.net>
#   2012-05-22
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters: (see <examples/params.json> for Hiera configurations)
#
# Actions:
#
#   Configures user environments and manages users.
#
#   Provides the users::user() definition.
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

  $home                  = $users::params::home,
  $profile_file          = $users::params::profile_file,
  $bashrc_file           = $users::params::bashrc_file,
  $aliases_file          = $users::params::aliases_file,
  $editor                = $users::params::editor,
  $umask                 = $users::params::umask,
  $root_home             = $users::params::root_home,
  $root_profile          = $users::params::root_profile,
  $root_bashrc           = $users::params::root_bashrc,
  $root_aliases          = $users::params::root_aliases,
  $root_public_ssh_key   = $users::params::root_public_ssh_key,
  $root_private_ssh_key  = $users::params::root_private_ssh_key,
  $root_ssh_key_type     = $users::params::root_ssh_key_type,
  $root_profile_template = $users::params::root_profile_template,
  $root_bashrc_template  = $users::params::root_bashrc_template,
  $root_aliases_template = $users::params::root_aliases_template,
  $skel_home             = $users::params::skel_home,
  $skel_profile          = $users::params::skel_profile,
  $skel_bashrc           = $users::params::skel_bashrc,
  $skel_aliases          = $users::params::skel_aliases,
  $skel_profile_template = $users::params::skel_profile_template,
  $skel_bashrc_template  = $users::params::skel_bashrc_template,
  $skel_aliases_template = $users::params::skel_aliases_template,

) inherits users::params {

  $root_ssh_dir          = "${root_home}/.ssh"

  #-----------------------------------------------------------------------------
  # Root user information

  if $root_profile {
    file { 'root-profile':
      path    => $root_profile,
      content => template($root_profile_template),
    }
  }

  if $root_bashrc {
    file { 'root-bashrc':
      path    => $root_bashrc,
      content => template($root_bashrc_template),
    }
  }

  if $root_aliases {
    file { 'root-aliases':
      path    => $root_aliases,
      content => template($root_aliases_template),
    }
  }

  file { 'root-ssh-dir':
    path    => $root_ssh_dir,
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
  }

  if $root_public_ssh_key {
    file { 'root-public-key':
      path    => "${root_ssh_dir}/id_${root_ssh_key_type}.pub",
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => $root_public_ssh_key,
      require => File['root-ssh-dir'],
    }
  }

  if $root_private_ssh_key {
    file { 'root-private-key':
      path    => "${root_ssh_dir}/id_${root_ssh_key_type}",
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      content => $root_private_ssh_key,
      require => File['root-ssh-dir'],
    }
  }

  #-----------------------------------------------------------------------------
  # Normal user profile information

  if $skel_profile {
    file { 'skel-profile':
      path    => $skel_profile,
      content => template($skel_profile_template),
    }
  }

  if $skel_bashrc {
    file { 'skel-bashrc':
      path    => $skel_bashrc,
      content => template($skel_bashrc_template),
    }
  }

  if $skel_aliases {
    file { 'skel-aliases':
      path    => $skel_aliases,
      content => template($skel_aliases_template),
    }
  }
}
