
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
  $user_ensure               = 'present'
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
}
