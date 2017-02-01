
env  = ENV['PUPPET_ENV'] || 'dev'


Vagrant.configure("2") do |config|
  config.vm.provision :shell, :inline => LOCAL_UPDATE || UPDATE

  config.vm.provision :shell, :inline => 'sudo apt install apt-transport-https' 
  config.vm.define :default do |node|
    node.vm.provision :puppet do |puppet|
	puppet.manifests_path = 'manifests'
	puppet.manifest_file  = 'default.pp'
	puppet.options = "--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml --environment=#{env}"
    end
  end
end
