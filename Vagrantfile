VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.5.0"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
  config.vm.provision "shell", path: "./config.sh"
end
