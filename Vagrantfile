Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.ssh.forward_agent = true

  # Want to cd there because that directory is by default synced with
  # directory of this Vagrant file.
  # https://stackoverflow.com/questions/17864047
  config.ssh.extra_args = ["-t", "cd /vagrant; bash --login"]

  config.vm.provider "virtualbox" do |v|
    v.linked_clone = true

    # Specific the hh_test, to try to fix a memory error encountered in at least
    # one test (which is run during make). Default should be 512 (MB).
    v.memory = 4096
    v.cpus = 4
  end

  # neither of these answers from here seemed to work (w/ rel symlink at least):
  # https://stackoverflow.com/questions/24200333

  # 1
  #config.vm.provider "virtualbox" do |v|
  #    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  #end

  # 2
  #config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__args: ["--verbose", "--archive", "--delete", "-z"]
end
