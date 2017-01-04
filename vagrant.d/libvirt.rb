Vagrant.configure("2") do |config|

  pool = ENV['VAGRANT_POOL'] 
  device = ENV['VAGRANT_BRIDGE'] || 'eth0'

  config.vm.provider :libvirt do |domain, override|
    override.vm.network :public_network, :bridge => device , :dev => device
    domain.uri = 'qemu+unix:///system'
    domain.memory = 4048
    domain.cpus = 2
    domain.storage_pool_name = pool if pool
    override.vm.synced_folder './', '/vagrant', type: 'nfs', nfs_udp: false, nfs_version: 4

 end


end
