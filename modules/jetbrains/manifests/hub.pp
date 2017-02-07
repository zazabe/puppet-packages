class jetbrains::hub (
  $host,
  $ssl_cert,
  $ssl_key,
  $version = '2.5',
  $build   = '450',
  $port    = 8080,
) {

  jetbrains::application { 'hub':
    host         => $host,
    ssl_cert     => $ssl_cert,
    ssl_key      => $ssl_key,
    version      => $version,
    build        => $build,
    port         => $port,
    download_url => "https://download.jetbrains.com/hub/${version}/hub-ring-bundle-${version}.${build}.zip"
  }

}
