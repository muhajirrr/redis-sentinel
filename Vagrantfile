# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

cluster = {
  "redis-m1" => { :ip => "192.168.16.104", :cpus => 1, :mem => 512, :provision => "master/run.sh" },
  "redis-r1" => { :ip => "192.168.16.105", :cpus => 1, :mem => 512, :provision => "slave/run.sh" },
  "redis-r2" => { :ip => "192.168.16.106", :cpus => 1, :mem => 512, :provision => "slave/run.sh" },
  "wp-redis" => { :ip => "192.168.16.107", :cpus => 1, :mem => 512, :provision => "wp-redis/run.sh" }
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  cluster.each_with_index do |(hostname, info), index|

    config.vm.define hostname do |node|
      node.vm.hostname = hostname
      node.vm.box = "ubuntu/bionic64"
      node.vm.network :private_network, ip: "#{info[:ip]}"

      node.vm.provider :virtualbox do |vb|
        vb.name = hostname
        vb.gui = false
        vb.memory = info[:mem]
        vb.cpus = info[:cpus]
      end

      node.vm.provision "shell", run: "once", path: info[:provision], args: [info[:ip]]
    end

  end

end
