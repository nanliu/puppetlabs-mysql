# Class: mysql::python
#
# This class installs the python libs for mysql.
#
# Parameters:
#   [*ensure*]       - ensure state for package.
#                        can be specified as version.
#   [*package_name*] - name of package
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mysql::python(
  $package_name   = hiera('mysql_python_package_name'),
  $package_ensure = hiera('mysql_python_package_version', 'present')
) {

  package { 'python-mysqldb':
    name   => $package_name,
    ensure => $package_ensure,
  }

}
