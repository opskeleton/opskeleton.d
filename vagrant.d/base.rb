unless ENV['SKIP_DEFAULTS']
  require_relative 'mirror'
  require_relative 'provision'
  require_relative 'caching'
  require_relative 'libvirt'
end
