
MIRROR=ENV['MIRROR'] || 'us.archive.ubuntu.com'

UPDATE= <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo sed -i.bak "s/us.archive.ubuntu.com/#{MIRROR}/g" /etc/apt/sources.list
  sudo sed -i.bak '/deb-src/d' /etc/apt/sources.list
  sudo apt-get update
  touch /tmp/up
fi
SCRIPT

if File.directory?("#{Dir.pwd}/mirror")
  LOCAL_UPDATE= <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo echo '#{MIRROR} aptmirror' >> /etc/hosts
  sudo cp -r /vagrant/mirror/* /etc/apt/  
  sudo apt-get update
  touch /tmp/up
fi
SCRIPT
else
  LOCAL_UPDATE = nil
end


