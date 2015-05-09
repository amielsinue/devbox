box      = 'trusty64'
url      = 'http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'
hostname = 'devbox.net'
ip       = '10.10.10.10'
ram      = '2048'
cpus     = '2'
cap      = '50'

Vagrant.configure("2") do |config|
  config.vm.box = box
  config.vm.box_url = url
  config.vm.hostname = hostname
  config.vm.network :private_network, ip: ip
  config.vm.synced_folder "../", "/Public", create: true, mount_options: ["dmode=777", "fmode=666"]
  config.vm.provision :shell, :inline => 'apt-get update'

  config.vm.provider "virtualbox" do |vbox|
      vbox.name = hostname
      vbox.customize [
          "modifyvm", :id,
          "--groups", "/devbox",
          "--memory", ram,
          "--cpus", cpus,
          "--cpuexecutioncap", cap
      ]
      #vbox.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate//Public", "1"]
  end


  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.manifest_file = 'lamp.pp'
    puppet.module_path = 'puppet/modules'
  end

  config.vm.provision "shell", path: 'utils/set-up.sh'
end
