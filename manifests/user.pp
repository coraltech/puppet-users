
define users::user(

  $ensure               = $users::params::user_ensure,
  $group                = $users::params::user_group ? {
    ''                   => $name,
    default              => $users::params::user_group,
  },
  $alt_groups           = $users::params::user_alt_groups,
  $email                = $users::params::user_email ? {
    ''                   => "system@${::hostname}",
    default              => $users::params::user_email,
  },
  $home                 = $users::params::user_home ? {
    ''                   => "${users::params::os_user_home}/${name}",
    default              => $users::params::user_home,
  },
  $comment              = $users::params::user_comment ? {
    ''                   => "User ${name}",
    default              => $users::params::user_comment,
  },
  $allowed_ssh_key      = $users::params::user_allowed_ssh_key,
  $allowed_ssh_key_type = $users::params::user_allowed_ssh_key_type,
  $public_ssh_key       = $users::params::user_public_ssh_key,
  $private_ssh_key      = $users::params::user_private_ssh_key,
  $ssh_key_type         = $users::params::user_ssh_key_type,
  $password             = $users::params::user_password,
  $shell                = $users::params::user_shell,
  $system               = $users::params::user_system,

) {

  $ssh_dir = "$home/.ssh"

  include users

  #-----------------------------------------------------------------------------
  # User and home directory

  if ! defined(Group[$group]) {
    group { $group:
      ensure  => $ensure,
      system  => $system ? {
        'true'  => true,
        default => false,
      },
      require => Class['users'],
    }
  }

  user { $name:
    password   => $password,
    gid        => $group,
    groups     => $alt_groups,
    comment    => $comment,
    ensure     => $ensure,
    home       => $home,
    managehome => true,
    shell      => $shell,
    system     => $system ? {
      'true' => true,
      default => false,
    },
    require    => Group[$group],
  }

  file { $home:
    ensure  => directory,
    owner   => $name,
    group   => $group,
    recurse => true,
    require => User[$name],
  }

  #-----------------------------------------------------------------------------
  # SSH keys

  file { $ssh_dir:
    ensure  => directory,
    owner   => $name,
    group   => $group,
    mode    => '700',
    require => File[$home],
  }

  if $public_ssh_key {
    file { "${ssh_dir}/id_${ssh_key_type}.pub":
      owner   => $name,
      group   => $name,
      mode    => 644,
      content => $public_ssh_key,
      require => File[$ssh_dir],
    }
  }

  if $private_ssh_key {
    file { "${ssh_dir}/id_${ssh_key_type}":
      owner   => $name,
      group   => $name,
      mode    => 600,
      content => $private_ssh_key,
      require => File[$ssh_dir],
    }
  }

  if $allowed_ssh_key {
    ssh_authorized_key { "${name}-${allowed_ssh_key_type}-key":
      ensure  => 'present',
      key     => $allowed_ssh_key,
      type    => $allowed_ssh_key_type,
      target  => "${ssh_dir}/authorized_keys",
      user    => $name,
      require => File[$ssh_dir],
    }
  }
}
