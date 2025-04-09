
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

  config.vm.define "cp" do |node|
    node.vm.hostname = "cp"

    node.vm.network "forwarded_port", guest: 3000, host: 3000 # grafana
    node.vm.network "forwarded_port", guest: 9090, host: 9090 # prometheus
    node.vm.network "forwarded_port", guest: 9100, host: 9100 # prometheus-node-exporter
    node.vm.network "forwarded_port", guest: 5201, host: 52000 # iperf3

    cp_config.call(node)
  end

  node_config = lambda do |config|
    config.vm.provider :utm do |v|
      v.memory = 4096
      v.cpus = 2
    end
  end

  config.vm.define "node1" do |node|
    node.vm.hostname = "node1"
    node.vm.network "forwarded_port", guest: 9100, host: 9101 # prometheus-node-exporter
    node.vm.network "forwarded_port", guest: 5201, host: 52001 # iperf3
    node_config.call(node)
  end

  config.vm.define "node2" do |node|
    node.vm.hostname = "node2"
    node.vm.network "forwarded_port", guest: 9100, host: 9102 # prometheus-node-exporter
    node.vm.network "forwarded_port", guest: 5201, host: 52002 # iperf3
    node_config.call(node)
  end
end