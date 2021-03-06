require 'spec_helper'

describe 'Ubuntu 14.04 OS image', os_image: true do
  it_behaves_like 'an OS image'

  describe package('apt') do
    it { should be_installed }
  end

  describe package('rpm') do
    it { should_not be_installed }
  end

  context 'installed by base_debootstrap' do
    %w(
      adduser
      apt
      apt-utils
      bzip2
      ca-certificates
      console-setup
      dash
      debconf
      eject
      gnupg
      ifupdown
      initramfs-tools
      iproute2
      iputils-ping
      isc-dhcp-client
      kbd
      less
      locales
      lsb-release
      makedev
      mawk
      module-init-tools
      net-tools
      netbase
      netcat-openbsd
      ntpdate
      passwd
      procps
      sudo
      tzdata
      ubuntu-keyring
      udev
      upstart
      ureadahead
      vim-tiny
      whiptail
    ).each do |pkg|
      describe package(pkg) do
        it { should be_installed }
      end
    end

    describe file('/etc/lsb-release') do
      it { should be_file }
      it { should contain 'DISTRIB_RELEASE=14.04' }
      it { should contain 'DISTRIB_CODENAME=trusty' }
    end
  end

  context 'installed by base_apt' do
    %w(
      upstart
      build-essential
      libssl-dev
      lsof
      strace
      bind9-host
      dnsutils
      tcpdump
      iputils-arping
      curl
      wget
      libcurl3
      libcurl4-openssl-dev
      bison
      libreadline6-dev
      libxml2
      libxml2-dev
      libxslt1.1
      libxslt1-dev
      zip
      unzip
      nfs-common
      flex
      psmisc
      apparmor-utils
      iptables
      sysstat
      rsync
      openssh-server
      traceroute
      libncurses5-dev
      quota
      libaio1
      gdb
      tripwire
      libcap2-bin
      libcap-dev
      libbz2-dev
      cmake
      scsitools
      mg
      htop
      module-assistant
      debhelper
      runit
      sudo
      uuid-dev
      libgcrypt11-dev
    ).each do |pkg|
      describe package(pkg) do
        it { should be_installed }
      end
    end

    describe file('/sbin/rescan-scsi-bus') do
      it { should be_file }
      it { should be_executable }
    end
  end

  context 'installed by system_grub' do
    %w(
      grub
    ).each do |pkg|
      describe package(pkg) do
        it { should be_installed }
      end
    end

    %w(e2fs_stage1_5 stage1 stage2).each do |grub_stage|
      describe file("/boot/grub/#{grub_stage}") do
        it { should be_file }
      end
    end
  end

  context 'installed by system_kernel' do
    %w(
      linux-headers-virtual
      linux-image-virtual
      linux-image-extra-virtual
    ).each do |pkg|
      describe package(pkg) do
        it { should be_installed }
      end
    end
  end

  context 'installed by bosh_user' do
    describe file('/etc/passwd') do
      it { should be_file }
      it { should contain '/home/vcap:/bin/bash' }
    end
  end

  context 'installed from source' do
    describe package('libyaml-dev') do
      it { should_not be_installed }
    end
  end
end
