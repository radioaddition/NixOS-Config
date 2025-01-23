{ config, pkgs, inputs, lib, ... }: {

  # AppArmor
  services.dbus.apparmor = "enabled";
  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = true;
    enableCache = true;
  };

  # Enable GnuPG
  services.pcscd.enable = true;
  programs.gnupg.agent = {
   enable = true;
   pinentryPackage = pkgs.pinentry-gnome3;
   enableSSHSupport = true;
  };

  # Restrict Nix access
#  nix.settings.allowed-users = [ "radioaddition" ];

  # Disable sudo in favor of run0
  # security.sudo.enable = false; # disabled while run0 is broken

  # Yubikey Pam login
  security.pam.yubico = {
   enable = true;
   mode = "challenge-response";
   id = [ "27725426" ];
  };
  # Lock device upon removal
  #services.udev.extraRules = ''
  #    ACTION=="remove",\
  #     ENV{ID_BUS}=="usb",\
  #     ENV{ID_MODEL_ID}=="0407",\
  #     ENV{ID_VENDOR_ID}=="1050",\
  #     ENV{ID_VENDOR}=="Yubico",\
  #     RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  #'';

  # USBGuard
  users.users.radioaddition.packages = [ pkgs.usbguard-notifier ];
  services.usbguard = {
    enable = true;
    presentControllerPolicy = "apply-policy";
    IPCAllowedUsers = [
      "root"
      "radioaddition"
    ];
  };

  # Enable secure boot
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  # Disable CUPS
  services.printing.enable = false;

  # Use dbus-broker instead of dbus
  services.dbus.implementation = "broker";


  # Temporary options
  security.allowUserNamespaces = true;
  security.unprivilegedUsernsClone  = true;

  # copied and modified from hardened.nix profile
  boot.kernelPackages = pkgs.linuxPackages_hardened;

  #environment.memoryAllocator.provider = "graphene-hardened";
  # Use the options if the graphene hardened_malloc is too strict
  environment.memoryAllocator.provider = "scudo";
  environment.variables.SCUDO_OPTIONS = "ZeroContents=1";

  security = {
    sudo.execWheelOnly = true;

    lockKernelModules = true;

    protectKernelImage = true;

    allowSimultaneousMultithreading = true;

    forcePageTableIsolation = true;

    # This is required by podman to run containers in rootless mode.
    unprivilegedUsernsClone = config.virtualisation.containers.enable;

    virtualisation.flushL1DataCache = "always";
  };

  boot = {
    kernelParams = [
      # Don't merge slabs
      "slab_nomerge"

      # Overwrite free'd pages
      "page_poison=1"

      # Enable page allocator randomization
      "page_alloc.shuffle=1"

      # Disable debugfs
      "debugfs=off"
    ];

    blacklistedKernelModules = [
      # Obscure network protocols
      "af_802154"
      "appletalk"
      "atm"
      "ax25"
      "can"
      "dccp"
      "decnet"
      "econet"
      "ipx"
      "n-hdlc"
      "netrom"
      "p8022"
      "p8023"
      "psnap"
      "rds"
      "rose"
      "sctp"
      "tipc"
      "x25"

      # firewire and thunderbolt
      "firewire-core"
      "firewire_core"
      "firewire-ohci"
      "firewire_ohci"
      "firewire_sbp2"
      "firewire-sbp2"
      "firewire-net"
      "thunderbolt"
      "ohci1394"
      "sbp2"
      "dv1394"
      "raw1394"
      "video1394"

      # Old or rare or insufficiently audited filesystems
      "9p"
      "adfs"
      "affs"
      "afs"
      "befs"
      "bfs"
      "ceph"
      "cifs"
      "coda"
      "cramfs"
      "ecryptfs"
      "efs"
      "erofs"
      "exofs"
      "f2fs"
      "freevxfs"
      "gfs2"
      "hfs"
      "hfsplus"
      "hpfs"
      "jffs2"
      "jfs"
      "kafs"
      "ksmbd"
      "minix"
      "netfs"
      "nfs"
      "nfsv3"
      "nfsv4"
      "nilfs2"
      "nilfs2"
      "ntfs"
      "ocfs2"
      "omfs"
      "orangefs"
      "qnx4"
      "qnx6"
      "reiserfs"
      "romfs"
      "squashfs"
      "sysv"
      "sysv"
      "ubifs"
      "udf"
      "ufs"
      "ufs"
      "zonefs"
      
      # disable vivid
      "vivid"
      
      # disable GNSS
      "gnss"
      "gnss-mtk"
      "gnss-serial"
      "gnss-sirf"
      "gnss-usb"
      "gnss-ubx"
      
      # blacklist ath_pci
      "ath_pci"
      
      # blacklist cdrom
      "cdrom"
      "sr_mod"
      
      # blacklist framebuffer drivers
      # source, ubuntu: https://git.launchpad.net/ubuntu/+source/kmod/tree/debian/modprobe.d/blacklist-framebuffer.conf
      "cyber2000fb"
      "cyblafb"
      "gx1fb"
      "hgafb"
      "kyrofb"
      "lxfb"
      "matroxfb_base"
      "neofb"
      "nvidiafb"
      "pm2fb"
      "s1d13xxxfb"
      "sisfb"
      "tdfxfb"
      "vesafb"
      "vfb"
      "vt8623fb"
      "udlfb"
    ];

    # Hide kptrs even for processes with CAP_SYSLOG
    kernel.sysctl."kernel.kptr_restrict" = lib.mkOverride 500 2;

    # Disable bpf() JIT (to eliminate spray attacks)
    kernel.sysctl."net.core.bpf_jit_enable" = false;

    # Disable ftrace debugging
    kernel.sysctl."kernel.ftrace_enabled" = false;

    # Enable strict reverse path filtering (that is, do not attempt to route
    # packets that "obviously" do not belong to the iface's network; dropped
    # packets are logged as martians).
    kernel.sysctl."net.ipv4.conf.all.log_martians" = true;
    kernel.sysctl."net.ipv4.conf.all.rp_filter" = "1";
    kernel.sysctl."net.ipv4.conf.default.log_martians" = true;
    kernel.sysctl."net.ipv4.conf.default.rp_filter" = "1";

    # Ignore broadcast ICMP (mitigate SMURF)
    kernel.sysctl."net.ipv4.icmp_echo_ignore_broadcasts" = true;

    # Ignore incoming ICMP redirects (note: default is needed to ensure that the
    # setting is applied to interfaces added after the sysctls are set)
    kernel.sysctl."net.ipv4.conf.all.accept_redirects" = false;
    kernel.sysctl."net.ipv4.conf.all.secure_redirects" = false;
    kernel.sysctl."net.ipv4.conf.default.accept_redirects" = false;
    kernel.sysctl."net.ipv4.conf.default.secure_redirects" = false;
    kernel.sysctl."net.ipv6.conf.all.accept_redirects" = false;
    kernel.sysctl."net.ipv6.conf.default.accept_redirects" = false;

    # Ignore outgoing ICMP redirects (this is ipv4 only)
    kernel.sysctl."net.ipv4.conf.all.send_redirects" = false;
    kernel.sysctl."net.ipv4.conf.default.send_redirects" = false;
  };
}
