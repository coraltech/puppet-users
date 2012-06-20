
class users::params {

  #-----------------------------------------------------------------------------

  $editor    = 'vim'
  $umask     = 002

  $root_home = '/root'
  $root_name   = 'Root account'
  $root_email  = ''

  $skel_home = '/etc/skel'
  $skel_name   = 'User account'
  $skel_email  = ''

  case $::operatingsystem {
    debian: {}
    ubuntu: {}
    centos, redhat: {}
  }
}
