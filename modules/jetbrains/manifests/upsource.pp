class jetbrains::upsource (
  $host,
  $ssl_cert,
  $ssl_key,
  $version = '3.5',
  $build   = '3616',
  $port    = 8082,
  $hub_url = undef,
) {

  jetbrains::application { 'upsource':
    host         => $host,
    ssl_cert     => $ssl_cert,
    ssl_key      => $ssl_key,
    version      => $version,
    build        => $build,
    port         => $port,
    download_url => "https://download.jetbrains.com/upsource/upsource-${version}.${build}.zip",
    config       => file("${module_name}/upsource.config"),
    hub_url      => $hub_url,
  }

  require 'composer'

  ensure_packages(['libxrender1', 'libxext6'], { provider => 'apt' })
}
