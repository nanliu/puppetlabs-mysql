# Class: mysql::data
#
# The mysql configuration settings.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mysql::data {

  case $::osfamily {
    'RedHat': {
      $mysql_service_name          = 'mysqld'
      $mysql_client_package_name   = 'mysql'
      $mysql_socket                = '/var/lib/mysql/mysql.sock'
      $mysql_config_file           = '/etc/my.cnf'
      $mysql_ruby_package_name     = 'ruby-mysql'
      $mysql_ruby_package_provider = 'gem'
      $mysql_python_package_name   = 'MySQL-python'
    }

    'Debian': {
      $mysql_service_name         = 'mysql'
      $mysql_client_package_name  = 'mysql-client'
      $mysql_socket               = '/var/run/mysqld/mysqld.sock'
      $mysql_config_file          = '/etc/mysql/my.cnf'
      $mysql_ruby_package_name    = 'libmysql-ruby'
      $mysql_python_package_name  = 'python-mysqldb'
    }

    default: {
      fail("Unsupported operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily RedHat and Debian")
    }
  }

}
