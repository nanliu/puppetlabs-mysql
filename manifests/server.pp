# Class: mysql::server
#
# manages the installation of the mysql server.
#   manages the package, service, my.cnf
#
# Parameters:
#   [*config_hash*]       - hash of config parameters that need to be set.
#   [*service_name*]      - name of service
#   [*package_name*]      - name of package
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mysql::server (
  $package_name   = hiera('mysql_server_package_name', 'mysql-server'),
  $package_ensure = hiera('mysql_server_package_ensure', 'present'),
  $service_name   = hiera('mysql_service_name'),
  $config_hash    = {}
) {

  create_resources( 'class', {'mysql::config' => $config_hash} )

  package { 'mysql-server':
    name   => $package_name,
    ensure => $package_ensure,
  }

  service { 'mysqld':
    name    => $service_name,
    ensure  => running,
    enable  => true,
    require => Package['mysql-server'],
  }

}
