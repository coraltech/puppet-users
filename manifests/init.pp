# Class: users
#
#   This module configures user environments and manages users.
#
#   Adrian Webb <adrian.webb@coraltg.com>
#   2012-05-22
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters:
#
#   $editor    = $users::params::editor,
#   $umask     = $users::params::umask,
#   $root_home = $users::params::root_home,
#   $skel_home = $users::params::skel_home
#
# Actions:
#
#   Configures user environments and manages users.
#
#   Provides the users::add_user() function.
#
# Requires:
#
# Sample Usage:
#
#   class { 'users':
#     editor => 'vim',
#     umask  => 002,
#  }
#
# [Remember: No empty lines between comments and class definition]
class users (

  $editor    = $users::params::editor,
  $umask     = $users::params::umask,
  $root_home = $users::params::root_home,
  $skel_home = $users::params::skel_home
)
inherits users::params {

  #-----------------------------------------------------------------------------
  # User profile information

  stage { 'users-bootstrap': }
  Stage['users-bootstrap'] -> Stage['main']

  class { 'users::files':
    editor => $editor,
    umask  => $umask,
    stage => 'users-bootstrap',
  }
}
