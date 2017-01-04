
MIRROR=ENV['MIRROR'] || 'us.archive.ubuntu.com'

UPDATE= <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo sed -i.bak "s/us.archive.ubuntu.com/#{MIRROR}/g" /etc/apt/sources.list
  sudo sed -i.bak '/deb-src/d' /etc/apt/sources.list
  sudo apt-get update
  touch /tmp/up
fi
SCRIPT

LOCAL_UPDATE= <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo echo '192.168.121.40 aptmirror' >> /etc/hosts
  sudo cp -r /vagrant/mirror/* /etc/apt/  
  sudo apt-get update
  touch /tmp/up
fi
SCRIPT


