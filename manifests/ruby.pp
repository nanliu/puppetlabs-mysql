# Class: mysql::ruby
#
# installs the ruby bindings for mysql
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
class mysql::ruby(
  $package_name     = hiera('mysql_ruby_package_name'),
  $package_ensure   = hiera('mysql_ruby_package_ensure', 'present'),
  $package_provider = hiera('mysql_ruby_package_provider', undef)
) {

  package{ 'ruby-mysql':
    name     => $package_name,
    provider => $package_provider,
    ensure   => $package_ensure,
  }

}
