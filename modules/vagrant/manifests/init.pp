class vagrant {

  $version = '1.7.3'
  $url = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.3_x86_64.deb'

  helper::script { 'install vagrant':
    content     => template("${module_name}/install.sh"),
    unless      => "vagrant --version | grep '^Vagrant ${version}$'",
    environment => ['HOME=/tmp'],   # Vagrant needs $HOME (https://github.com/mitchellh/vagrant/issues/2215)
  }
}
