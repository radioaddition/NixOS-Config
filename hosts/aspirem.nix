# Edit this configuration file to define what should be installed on
# you system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  # Additional system config
  hardware.enableAllFirmware = true;
  boot.extraModprobeConfig = ''
  options snd-intel-dspcfg dsp_driver=1
'';

  # Bootloader.

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };


  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-15e14bac-b357-4e9b-9102-723bff682c67".device = "/dev/disk/by-uuid/15e14bac-b357-4e9b-9102-723bff682c67";

  # Make sure to copy luks configuration from your current file if applicable

  networking.hostName = "aspirem"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Enable GnuPG
  services.pcscd.enable = true;
  programs.gnupg.agent = {
   enable = true;
   pinentryPackage = "pkgs.pinentry-gnome3";
   enableSSHSupport = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable flake support
  nix = {
    settings = {
      auto-optimise-store = true;
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  # Enable flatpak
  services.flatpak.enable = true;

  # Enable ADB/Fastboot
  programs.adb.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.radioaddition = {
    isNormalUser = true;
    description = "RadioAddition";
    extraGroups = [ "adbusers" "networkmanager" "wheel" "lxd" "libvirt" "libvirtd" "kvm" "docker" ];
    hashedPassword = "$y$j9T$gMRIRcus7uO1X6zrPTfVn/$0iOFINi8HZPH5b0QpXXCQbanUwYe9lpzjD17NbitD39";
  };
  services.vsftpd.localUsers = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable virtualisation
  virtualisation.kvmgt.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  
  # Enable syncthing
  services.syncthing = {
        enable = true;
        user = "radioaddition";
        dataDir = "/home/radioaddition/Syncthing";    # Default folder for new synced folders
        configDir = "/home/radioaddition/.config/syncthing";   # Folder for Syncthing's settings and keys
    };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Yubikey Support
  security.pam.yubico = {
   enable = true;
   mode = "challenge-response";
   id = [ "27725426" ];
  };
  # Lock device upon removal
  #services.udev.extraRules = ''
      #ACTION=="remove",\
       #ENV{ID_BUS}=="usb",\
       #ENV{ID_MODEL_ID}=="0407",\
       #ENV{ID_VENDOR_ID}=="1050",\
       #ENV{ID_VENDOR}=="Yubico",\
       #RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  #'';

  environment.systemPackages = with pkgs; [

    sbctl
    jamesdsp
    neovim
    wget
    curl
    gnome.dconf-editor
    git
    freshfetch
    hyfetch
    home-manager
    rsync
    firejail
    gparted
    syncthing
    mcron
    qemu
    qemu_kvm
    libvirt
    virt-manager
    docker
    docker-client
    docker-compose
    cryfs
    rpi-imager
    distrobox
    boxbuddy
 ];

  # enable zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [ 65530 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall.allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  networking.firewall.allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];
  security.acme.acceptTerms = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
