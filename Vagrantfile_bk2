# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "serverspec"
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box"
  config.vm.hostname="infra-testing"

  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.56.160"
  # config.vm.network "public_network"

  config.vbguest.auto_update = false

  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Update Chef utilities
  config.omnibus.chef_version = :latest
  
  # Call chef cookbook to install SW
  config.vm.provision :chef_solo do |chef|

    # Check chef cookbook directory
    chef.cookbooks_path = ["./cookbooks", "./site-cookbooks"]

    # Define attribute
    # chef.json = {
    #   nginx: {
    #     env: "ruby"
    #   },
    #   mysql: {
    #     server_root_password: 'rootpass'
    #   }
    # }

    # Apply cookbook
    chef.run_list = %w[
      recipe[ruby-env]
    ]
  end




  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    sudo -y update
    # sudo apt-get install -y apache2
  SHELL
end
