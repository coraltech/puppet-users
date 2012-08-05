
class users::params {

  include users::default

  #-----------------------------------------------------------------------------
  # General configurations

  if $::hiera_ready {
    $editor                    = hiera('users_editor', $users::default::editor)
    $umask                     = hiera('users_umask', $users::default::umask)
    $root_name                 = hiera('user_root_name', $users::default::root_name)
    $root_email                = hiera('user_root_email', $users::default::root_email)
    $root_public_ssh_key       = hiera('user_root_public_ssh_key', $users::default::root_public_ssh_key)
    $root_private_ssh_key      = hiera('user_root_private_ssh_key', $users::default::root_private_ssh_key)
    $root_ssh_key_type         = hiera('user_root_ssh_key_type', $users::default::root_ssh_key_type)
    $skel_name                 = hiera('user_skel_name', $users::default::skel_name)
    $skel_email                = hiera('user_skel_email', $users::default::skel_email)
    $user_ensure               = hiera('user_ensure', $users::default::user_ensure)
    $user_group                = hiera('user_group', $users::default::user_group)
    $user_alt_groups           = hiera('user_alt_groups', $users::default::user_alt_groups)
    $user_email                = hiera('user_email', $users::default::user_email)
    $user_home                 = hiera('user_home', $users::default::user_home)
    $user_comment              = hiera('user_comment', $users::default::user_comment)
    $user_allowed_ssh_key      = hiera('user_allowed_ssh_key', $users::default::user_allowed_ssh_key)
    $user_allowed_ssh_key_type = hiera('user_allowed_ssh_key_type', $users::default::user_allowed_ssh_key_type)
    $user_public_ssh_key       = hiera('user_public_ssh_key', $users::default::user_public_ssh_key)
    $user_private_ssh_key      = hiera('user_private_ssh_key', $users::default::user_private_ssh_key)
    $user_ssh_key_type         = hiera('user_ssh_key_type', $users::default::user_ssh_key_type)
    $user_password             = hiera('user_password', $users::default::user_password)
    $user_shell                = hiera('user_shell', $users::default::user_shell)
    $user_system               = hiera('user_system', $users::default::user_system)
  }
  else {
    $editor                    = $users::default::editor
    $umask                     = $users::default::umask
    $root_name                 = $users::default::root_name
    $root_email                = $users::default::root_email
    $root_public_ssh_key       = $users::default::root_public_ssh_key
    $root_private_ssh_key      = $users::default::root_private_ssh_key
    $root_ssh_key_type         = $users::default::root_ssh_key_type
    $skel_name                 = $users::default::skel_name
    $skel_email                = $users::default::skel_email
    $user_ensure               = $users::default::user_ensure
    $user_group                = $users::default::user_group
    $user_alt_groups           = $users::default::user_alt_groups
    $user_email                = $users::default::user_email
    $user_home                 = $users::default::user_home
    $user_comment              = $users::default::user_comment
    $user_allowed_ssh_key      = $users::default::user_allowed_ssh_key
    $user_allowed_ssh_key_type = $users::default::user_allowed_ssh_key_type
    $user_public_ssh_key       = $users::default::user_public_ssh_key
    $user_private_ssh_key      = $users::default::user_private_ssh_key
    $user_ssh_key_type         = $users::default::user_ssh_key_type
    $user_password             = $users::default::user_password
    $user_shell                = $users::default::user_shell
    $user_system               = $users::default::user_system
  }

  #-----------------------------------------------------------------------------
  # Operating system specific configurations

  case $::operatingsystem {
    debian, ubuntu: {
      $os_root_home             = '/root'
      $os_root_profile          = "${os_root_home}/.profile"
      $os_root_profile_template = 'users/root/debian.profile.erb'
      $os_root_bashrc           = "${os_root_home}/.bashrc"
      $os_root_bashrc_template  = 'users/root/debian.bashrc.erb'
      $os_root_aliases          = "${os_root_home}/.bash_aliases"
      $os_root_aliases_template = 'users/root/debian.bash_aliases.erb'

      $os_skel_home             = '/etc/skel'
      $os_skel_profile          = "${os_skel_home}/.profile"
      $os_skel_profile_template = 'users/skel/debian.profile.erb'
      $os_skel_bashrc           = "${os_skel_home}/.bashrc"
      $os_skel_bashrc_template  = 'users/skel/debian.bashrc.erb'
      $os_skel_aliases          = "${os_skel_home}/.bash_aliases"
      $os_skel_aliases_template = 'users/skel/debian.bash_aliases.erb'
    }
    default: {
      fail("The users module is not currently supported on ${::operatingsystem}")
    }
  }
}
