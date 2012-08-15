
define users::conf (

  $user             = $name,
  $owner            = $users::params::conf_owner ? {
    ''                   => $name,
    default              => $users::params::conf_owner,
  },
  $group            = $users::params::conf_group ? {
    ''                   => $name,
    default              => $users::params::conf_group,
  },
  $mode             = $users::params::conf_mode,
  $home             = $users::params::home,
  $profile_file     = $users::params::profile_file,
  $bashrc_file      = $users::params::bashrc_file,
  $aliases_file     = $users::params::aliases_file,
  $editor           = $users::params::editor,
  $umask            = $users::params::umask,
  $profile_template = $users::params::skel_profile_template,
  $bashrc_template  = $users::params::skel_bashrc_template,
  $aliases_template = $users::params::skel_aliases_template,

) {

  include users

  #-----------------------------------------------------------------------------
  # User profile information

  File {
    owner => $owner,
    group => $group,
    mode  => $mode,
  }

  if $profile_file {
    file { "${user}-profile":
      path    => "${home}/${name}/${profile_file}",
      content => template($profile_template),
    }
  }

  if $bashrc_file {
    file { "${user}-bashrc":
      path    => "${home}/${name}/${bashrc_file}",
      content => template($bashrc_template),
    }
  }

  if $aliases_file {
    file { "${user}-aliases":
      path    => "${home}/${name}/${aliases_file}",
      content => template($aliases_template),
    }
  }
}
