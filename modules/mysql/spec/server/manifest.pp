node default {

  include 'fluentd'

  class { 'mysql::server':
    root_password             => 'foo',
    debian_sys_maint_password => 'bar',
    key_buffer_size           => '8M',
    thread_cache_size         => 20,
    max_connections           => 10,
  }

  fluentd::config::match_copy { 'dump_to_file':
    pattern  => '**',
    priority => 85,
    stores   => [{
      'type'   => 'file',
      'path'   => '/tmp/dump',
      'format' => 'json',
    }]
  }

  exec { 'Execute a slow query':
    command  => 'mysql -e "select sleep (1.1);" -pfoo',
    user     => 'root',
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider => shell,
    require  => Class['mysql::server'],
  }
}
