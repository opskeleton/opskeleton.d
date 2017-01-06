
MIRROR=ENV['MIRROR'] || 'us.archive.ubuntu.com'

UPDATE= <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo sed -i.bak "s/us.archive.ubuntu.com/#{MIRROR}/g" /etc/apt/sources.list
  sudo sed -i.bak '/deb-src/d' /etc/apt/sources.list
  sudo apt-get update
  touch /tmp/up
fi
SCRIPT

LIST_D = '/etc/apt/sources.list.d'
LOCAL_UPDATE= <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo echo '#{MIRROR} aptmirror' >> /etc/hosts
  sudo rm /etc/apt/sources.list
  sudo echo 'deb http://aptmirror/ubuntu/ xenial-backports main restricted universe multiverse' >> #{LIST_D}/xenial-backports.list
  sudo echo 'deb http://aptmirror/ubuntu/ xenial partner' >> #{LIST_D}/xenial-extras.list
  sudo echo 'deb http://aptmirror/ubuntu-security/ xenial-security main restricted universe multiverse' >> #{LIST_D}/xenial-security.list
  sudo echo 'deb http://aptmirror/ubuntu/ xenial-updates main restricted universe multiverse' >> #{LIST_D}/xenial-updates.list
  sudo echo 'deb http://aptmirror/ubuntu/ xenial main restricted universe multiverse' >> #{LIST_D}/xenial.list
  sudo apt update
  touch /tmp/up
fi
SCRIPT
