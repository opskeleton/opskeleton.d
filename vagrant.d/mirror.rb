
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
  sudo echo '#{MIRROR} aptmirror' >> /etc/hosts
  sudo rm /etc/apt/sources.list
  sudo echo '' >> /etc/apt/sources.list
  sudo 'deb http://aptmirror/ubuntu/ xenial-backports main restricted universe multiverse' >> /etc/sources.list.d/xenial-backports.list
  sudo echo 'deb http://aptmirror/ubuntu/ xenial partner' >> /etc/sources.list.d/xenial-extras.list
  sudo 'deb http://aptmirror/ubuntu-security/ xenial-security main restricted universe multiverse' >> /etc/sources.list.d/xenial-security.list
  sudo 'deb http://aptmirror/ubuntu/ xenial-updates main restricted universe multiverse' >> /etc/sources.list.d/xenial-updates.list
  sudo 'deb http://aptmirror/ubuntu/ xenial main restricted universe multiverse' >> /etc/sources.list.d/xenial.list
  sudo apt-get update
  touch /tmp/up
fi
SCRIPT
