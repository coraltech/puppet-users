
define users::user(

  $group                = $name,
  $alt_groups           = [ ],
  $email                = "system@${::hostname}",
  $home                 = "/home/${name}",
  $comment              = "User ${name}",
  $allowed_ssh_key      = '',
  $allowed_ssh_key_type = 'rsa',
  $public_ssh_key       = undef,
  $private_ssh_key      = undef,
  $ssh_key_type         = 'rsa',
  $password             = undef,
  $shell                = '/bin/bash',
  $system               = false,

) {

  $ssh_path = "$home/.ssh"

  include users

  #-----------------------------------------------------------------------------
  # User and home directory

  group { $group:
    ensure  => 'present',
    require => Class['users'],
  }

  user { $name:
    password   => $password,
    gid        => $group,
    groups     => $alt_groups,
    comment    => $comment,
    ensure     => 'present',
    home       => $home,
    managehome => true,
    shell      => $shell,
    system     => $system,
    require    => Group[$group],
  }

  file { $home:
    ensure  => 'directory',
    owner   => $name,
    group   => $name,
    mode    => '755',
    require => User[$name],
  }

  #-----------------------------------------------------------------------------
  # SSH keys

  file { $ssh_path:
    ensure  => 'directory',
    owner   => $name,
    group   => $name,
    mode    => '700',
    require => File[$home],
  }

  if $public_ssh_key {
    file { "${ssh_path}/id_${ssh_key_type}.pub":
      owner   => $name,
      group   => $name,
      mode    => 644,
      content => $public_ssh_key,
      require => File[$ssh_path],
    }
  }

  if $private_ssh_key {
    file { "${ssh_path}/id_${ssh_key_type}":
      owner   => $name,
      group   => $name,
      mode    => 600,
      content => $private_ssh_key,
      require => File[$ssh_path],
    }
  }

  if $allowed_ssh_key {
    ssh_authorized_key { "${name}-${allowed_ssh_key_type}-key":
      ensure  => 'present',
      key     => $allowed_ssh_key,
      type    => $allowed_ssh_key_type,
      target  => "${ssh_path}/authorized_keys",
      user    => $name,
      require => File[$ssh_path],
    }
  }
}
