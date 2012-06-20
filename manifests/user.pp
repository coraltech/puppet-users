
define users::user(

  $group      = $name,
  $alt_groups = [ ],
  $email      = '',
  $home       = "/home/${name}",
  $comment    = "User ${name}",
  $ssh_key    = '',
  $key_type   = 'rsa',
  $shell      = '/bin/bash',
  $system     = false,

) {

  $ssh_path = "$home/.ssh"

  #-----------------------------------------------------------------------------
  # Create user and home directory

  file { $home:
    ensure  => 'directory',
    require => User[$name],
    owner   => $name,
    group   => $name,
    mode    => '755',
  }

  group { $group:
    ensure     => 'present',
    notify     => User[$name],
  }

  user { $name:
    gid        => $group,
    groups     => $alt_groups,
    comment    => $comment,
    ensure     => 'present',
    home       => $home,
    managehome => true,
    shell      => $shell,
    system     => $system,
  }

  #-----------------------------------------------------------------------------
  # Add SSH key

  file { $ssh_path:
    ensure  => 'directory',
    require => User[$name],
    owner   => $name,
    group   => $name,
    mode    => '700',
  }

  if $ssh_key {
    ssh_authorized_key { "${name}-${key_type}-key":
      ensure  => 'present',
      key     => "${ssh_key}${email}",
      type    => $key_type,
      user    => $name,
      require => File[$ssh_path],
      target  => "$ssh_path/authorized_keys",
    }
  }
}
