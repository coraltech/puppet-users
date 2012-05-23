
define users::user (
  $name     = $title,
  $groups   = [ ],
  $home     = '/home/${title}',
  $comment  = "User ${title}",
  $key      = '',
  $key_type = 'rsa'
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

  group { $groups: }

  user { $name:
    groups     => $groups,
    comment    => $comment,
    ensure     => 'present',
    home       => $home,
    managehome => true,
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

  if $key {
    ssh_authorized_key { "${name}-${key_type}-key":
      ensure  => 'present',
      key     => $key,
      type    => $key_type,
      user    => $name,
      require => File[$ssh_path],
      target  => "$ssh_path/authorized_keys",
    }
  }
}
