# Class: mysql::client
#
# this module installs mysql client software.
#
# Parameters:
#   [*client_package_name*]  - The name of the mysql client package.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mysql::client (
  $package_name   = hiera('mysql_client_package_name'),
  $package_ensure = hiera('msyql_client_package_ensure', 'present')
) {

  package { 'mysql_client':
    name    => $package_name,
    ensure  => $package_ensure,
  }

}
