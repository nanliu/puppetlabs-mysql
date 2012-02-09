class mysql::config(
  $root_password     = 'UNSET',
  $old_root_password = '',
  $bind_address      = hiera('mysql_bind_address', '127.0.0.1'),
  $port              = hiera('mysql_port', 3306),
  # rather or not to store the rootpw in /etc/my.cnf
  $etc_root_password = hiera('mysql_etc_root_password', false),
  $service_name      = hiera('mysql_service_name'),
  $config_file       = hiera('mysql_config_file'),
  $socket            = hiera('mysql_socket')
) {

  Class['mysql::server'] -> Class['mysql::config']

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    notify  => Exec['mysqld-restart'],
  }

  # this kind of sucks, that I have to specify a difference resource for restart.
  # the reason is that I need the service to be started before mods to the config
  # file which can cause a refresh
  exec { 'mysqld-restart':
    command     => "service ${service_name} restart",
    refreshonly => true,
    path        => '/sbin/:/usr/sbin/',
    require     => Package['mysql-server']
  }

  # manage root password if it is set
  if !($root_password == 'UNSET') {
    case $old_root_password {
      '':      { $old_pw='' }
      default: { $old_pw="-p${old_root_password}" }
    }

    exec { 'set_mysql_rootpw':
      command   => "mysqladmin -u root ${old_pw} password ${root_password}",
      logoutput => true,
      unless    => "mysqladmin -u root -p${root_password} status > /dev/null",
      path      => '/usr/local/sbin:/usr/bin',
    }

    file { '/root/.my.cnf':
      content => template('mysql/my.cnf.pass.erb'),
      require => Exec['set_mysql_rootpw'],
    }

    if $etc_root_password {
      file{ '/etc/my.cnf':
        content => template('mysql/my.cnf.pass.erb'),
        require => Exec['set_mysql_rootpw'],
      }
    }
  }


  file { '/etc/mysql':
    ensure => directory,
    mode   => '0755',
  }
  file { '/etc/mysql/conf.d':
    ensure => directory,
    mode   => '0755',
  }
  file { $config_file:
    content => template('mysql/my.cnf.erb'),
    mode    => '0644',
  }

}
