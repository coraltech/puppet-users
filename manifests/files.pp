
class users::files (

  $editor    = $users::params::editor,
  $umask     = $users::params::umask,
  $root_home = $users::params::root_home,
  $skel_home = $users::params::skel_home
)
inherits users::params {

  #-----------------------------------------------------------------------------
  # Root user profile information

  if $root_home {
    file {
      "${root_home}/.profile":
        owner   => 'root',
        group   => 'root',
        mode    => 640,
        content => template('users/root/.profile.erb');

      "${root_home}/.bashrc":
        owner   => 'root',
        group   => 'root',
        mode    => 640,
        content => template('users/root/.bashrc.erb');

      "${root_home}/.bash_aliases":
        owner  => 'root',
        group  => 'root',
        mode   => 640,
        source => 'puppet:///modules/users/.bash_aliases';
    }
  }

  #-----------------------------------------------------------------------------
  # Normal user profile information

  if $skel_home {
    file {
      "${skel_home}/.profile":
        owner   => "root",
        group   => "root",
        mode    => 640,
        content => template('users/skel/.profile.erb');

      "${skel_home}/.bashrc":
        owner    => 'root',
        group    => 'root',
        mode     => 640,
        content  => template('users/skel/.bashrc.erb');

      "${skel_home}/.bash_aliases":
        owner  => 'root',
        group  => 'root',
        mode   => 640,
        source => 'puppet:///modules/users/.bash_aliases';
    }
  }
}
