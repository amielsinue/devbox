class mysql {
  package { ['mysql-server']:
    ensure => present;
  }

  service { 'mysql':
    ensure  => running,
    require => Package['mysql-server'];
  }

  file { '/etc/mysql/my.cnf':
    source  => 'puppet:///modules/mysql/my.cnf',
    require => Package['mysql-server'],
    notify  => Service['mysql'];
  }

  exec { 'set-mysql-password':
    unless  => 'mysqladmin -uroot -proot status',
    command => "mysqladmin -uroot password root",
    path    => ['/bin', '/usr/bin'],
    require => Service['mysql'];
  }

  exec { 'reset-root-privileges':
    command => 'mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" IDENTIFIED BY \"root\" WITH GRANT OPTION; FLUSH PRIVILEGES;"',
    path    => ['/bin', '/usr/bin'],
    require => Exec['set-mysql-password'];
  }

  #exec { 'database-seed':
  #  command => 'mysql -u root -proot < /Public/db/seed.sql',
  #  path    => ['/bin', '/usr/bin'],
  #  timeout     => 7200,
  #  onlyif => "test -f /Public/db/seed.sql",
  #  require => Exec['reset-root-privileges'];
  #}

}
