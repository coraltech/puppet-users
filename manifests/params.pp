
class users::params inherits users::default {

  $home                      = module_param('home')
  $editor                    = module_param('editor')
  $umask                     = module_param('umask')

  #---

  $profile_file              = module_param('profile_file')
  $bashrc_file               = module_param('bashrc_file')
  $aliases_file              = module_param('aliases_file')

  $root_home                 = module_param('root_home')
  $root_profile              = module_param('root_profile')
  $root_profile_template     = module_param('root_profile_template')
  $root_bashrc               = module_param('root_bashrc')
  $root_bashrc_template      = module_param('root_bashrc_template')
  $root_aliases              = module_param('root_aliases')
  $root_aliases_template     = module_param('root_aliases_template')
  $root_name                 = module_param('root_name')
  $root_email                = module_param('root_email')
  $root_public_ssh_key       = module_param('root_public_ssh_key')
  $root_private_ssh_key      = module_param('root_private_ssh_key')
  $root_ssh_key_type         = module_param('root_ssh_key_type')

  $skel_home                 = module_param('skel_home')
  $skel_profile              = module_param('skel_profile')
  $skel_profile_template     = module_param('skel_profile_template')
  $skel_bashrc               = module_param('skel_bashrc')
  $skel_bashrc_template      = module_param('skel_bashrc_template')
  $skel_aliases              = module_param('skel_aliases')
  $skel_aliases_template     = module_param('skel_aliases_template')
  $skel_name                 = module_param('skel_name')
  $skel_email                = module_param('skel_email')

  $conf_owner                = module_param('conf_owner')
  $conf_group                = module_param('conf_group')
  $conf_mode                 = module_param('conf_mode')

  #---

  $user_ensure               = module_param('user_ensure')
  $user_gid                  = module_param('user_gid')
  $user_group                = module_param('user_group')
  $user_alt_groups           = module_array('user_alt_groups')
  $user_email                = module_param('user_email')
  $user_comment              = module_param('user_comment')
  $user_allowed_ssh_key      = module_param('user_allowed_ssh_key')
  $user_allowed_ssh_key_type = module_param('user_allowed_ssh_key_type')
  $user_public_ssh_key       = module_param('user_public_ssh_key')
  $user_private_ssh_key      = module_param('user_private_ssh_key')
  $user_ssh_key_type         = module_param('user_ssh_key_type')
  $user_password             = module_param('user_password')
  $user_shell                = module_param('user_shell')
  $user_system               = module_param('user_system')
}
