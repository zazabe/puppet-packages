class nginx::service {
  exec { 'rebuild-nginx-vhosts':
    command     => "/bin/cat ${nginx::params::nx_temp_dir}/nginx.d/* > ${nginx::params::nx_conf_dir}/conf.d/vhost_autogen.conf",
    refreshonly => true,
    unless      => "/usr/bin/test ! -f ${nginx::params::nx_temp_dir}/nginx.d/*",
    subscribe   => File["${nginx::params::nx_temp_dir}/nginx.d"],
  }
  service { 'nginx':
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Exec['rebuild-nginx-vhosts'],
  }
}
