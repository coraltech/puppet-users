
class users::default {

  $editor                    = 'vim'
  $umask                     = 002

  $root_name                 = 'Root account'
  $root_email                = ''
  $root_public_ssh_key       = ''
  $root_private_ssh_key      = ''
  $root_ssh_key_type         = 'rsa'

  $skel_name                 = 'User account'
  $skel_email                = ''

  $conf_owner                = ''
  $conf_group                = ''
  $conf_mode                 = '0644'

  $user_ensure               = 'present'
  $user_gid                  = ''
  $user_group                = ''
  $user_alt_groups           = [ ]
  $user_email                = ''
  $user_home                 = ''
  $user_comment              = ''
  $user_allowed_ssh_key      = ''
  $user_allowed_ssh_key_type = 'rsa'
  $user_public_ssh_key       = ''
  $user_private_ssh_key      = ''
  $user_ssh_key_type         = 'rsa'
  $user_password             = ''
  $user_shell                = '/bin/bash'
  $user_system               = 'false'

  #---

  case $::operatingsystem {
    debian, ubuntu: {
      $home                  = '/home'

      $profile_file          = '.profile'
      $bashrc_file           = '.bashrc'
      $aliases_file          = '.bash_aliases'

      $root_home             = '/root'
      $root_profile          = "${root_home}/${profile_file}"
      $root_profile_template = 'users/root/debian.profile.erb'
      $root_bashrc           = "${root_home}/${bashrc_file}"
      $root_bashrc_template  = 'users/root/debian.bashrc.erb'
      $root_aliases          = "${root_home}/${aliases_file}"
      $root_aliases_template = 'users/root/debian.bash_aliases.erb'

      $skel_home             = '/etc/skel'
      $skel_profile          = "${skel_home}/${profile_file}"
      $skel_profile_template = 'users/skel/debian.profile.erb'
      $skel_bashrc           = "${skel_home}/${bashrc_file}"
      $skel_bashrc_template  = 'users/skel/debian.bashrc.erb'
      $skel_aliases          = "${skel_home}/${aliases_file}"
      $skel_aliases_template = 'users/skel/debian.bash_aliases.erb'
    }
    default: {
      fail("The users module is not currently supported on ${::operatingsystem}")
    }
  }
}
