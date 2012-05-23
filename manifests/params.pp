
class users::params {

  #-----------------------------------------------------------------------------

  $root_home = '/root'
  $skel_home = '/etc/skel'

  case $::operatingsystem {
    debian: {}
    ubuntu: {
      $vim_version = '2:7.3.429-2ubuntu2'
    }
    centos, redhat: {}
  }
}
