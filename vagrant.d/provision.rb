MIRROR=ENV['MIRROR'] || 'us.archive.ubuntu.com'

env  = ENV['PUPPET_ENV'] || 'dev'

UPDATE= <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo sed -i.bak "s/us.archive.ubuntu.com/#{MIRROR}/g" /etc/apt/sources.list
  sudo sed -i.bak '/deb-src/d' /etc/apt/sources.list
  sudo apt-get update
  touch /tmp/up
fi
SCRIPT


Vagrant.configure("2") do |config|
  config.vm.provision :shell, :inline => UPDATE
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'manifests'
    puppet.manifest_file  = 'default.pp'
    puppet.options = "--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml --environment=#{env}"

  end


end
