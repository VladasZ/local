
Vagrant.configure("2") do |config|

  # vagrant plugin install vagrant_utm
  config.vm.box = "utm/bookworm"
  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/vagrant", disabled: true

  cp_config = lambda do |config|
    config.vm.provider :utm do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

  config.vm.define "cp" do |cp|
    cp.vm.hostname = "cp"
    cp_config.call(cp)
  end

  node_config = lambda do |config|
    config.vm.provider :utm do |v|
      v.memory = 4096
      v.cpus = 2
    end
  end

  config.vm.define "node1" do |node|
    node.vm.hostname = "node1"
    node_config.call(node)
  end

  config.vm.define "node2" do |node|
    node.vm.hostname = "node2"
    node_config.call(node)
  end
end