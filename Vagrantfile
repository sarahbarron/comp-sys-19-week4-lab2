VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.define "webserver" do |webserver|
        webserver.vm.hostname = "webserver"
        webserver.vm.network :private_network, ip: "192.168.5.2"
        webserver.vm.provision :shell, inline: "apt-get update && apt-get install -y mysql-client"
    end

    config.vm.define "dbserver" do |dbserver|
        dbserver.vm.hostname = "dbserver"
        dbserver.vm.provision :shell, path: "provision-dbserver.sh"
        dbserver.vm.network :private_network, ip: "192.168.5.3"
    end

    config.vm.box = "frankwalsh/labvm"
    config.ssh.forward_x11 = true
    config.vm.provider "virtualbox" do |v| 
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
end