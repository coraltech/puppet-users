
class users::params {

  #-----------------------------------------------------------------------------

  $editor    = 'vim'
  $umask     = 002

  $root_home = '/root'
  $skel_home = '/etc/skel'

  case $::operatingsystem {
    debian: {}
    ubuntu: {}
    centos, redhat: {}
  }
}
