class nodejs(
  $npm_version = '1.4.10'
) {

  require 'apt::source::backports'

  package { 'nodejs':
    ensure => present,
  }
  package { 'nodejs-legacy':
    ensure => present
  }

  exec { 'install npm':
    command => "curl -sL https://www.npmjs.com/install.sh | clean=yes npm_install=${npm_version} sh",
    unless  => 'test -x /usr/bin/npm && /usr/bin/npm -v',
    path    => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require => Package['nodejs-legacy'],
  }

}
