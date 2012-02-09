# Mysql module for Puppet


## Description
This module has evolved and is originally based on work by David Schmitt.  If
anyone else was involved in the development of this module and wants credit,
let Puppetlabs know.

## Usage

### mysql
Installs the mysql-client package.

    class { 'mysql::client': }

### mysql::python
Installs mysql bindings for python.

    class { 'mysql::python': }

### mysql::ruby
Installs mysql bindings for ruby.

    class { 'mysql::ruby': }

### mysql::server
Installs mysql-server, starts service, sets `root_pw`, and sets root.

    class { 'mysql::server':
      config_hash => { 'root_password' => 'foo' }
    }

Login information in `/etc/.my.cnf` and `/root/.my.cnf`.

### mysql::db
Creates a database with a user and assign some privileges.

    mysql::db { 'mydb':
      user     => 'myuser',
      password => 'mypass',
      host     => 'localhost',
      grant    => ['all'],
    }

### Providers for database types:

    database { 'mydb':
      charset => 'latin1',
    }

    database_user { 'bob@localhost':
      password_hash => mysql_password('foo')
    }

    database_grant { 'user@localhost/database':
      privileges => ['all'] ,
    }
