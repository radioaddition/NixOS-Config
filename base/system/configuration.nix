{ config, pkgs, inputs, lib, ... }: {

  ## Display


  #' Enable touchpad support (enabled default in most desktopManager).
  #' services.xserver.libinput.enable = true;

  # Packages/Programs/Services


  # User
  ## Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.radioaddition = {
    isNormalUser = true;
    description = "RadioAddition";
    extraGroups = [ "adbusers" "docker" "kvm" "libvirt" "libvirtd" "lxd" "networkmanager" "openrazer" "wheel" ];
    hashedPassword = "$y$j9T$gMRIRcus7uO1X6zrPTfVn/$0iOFINi8HZPH5b0QpXXCQbanUwYe9lpzjD17NbitD39";
    packages = (with pkgs; [

      # Packages
  
      adwsteamgtk
      atuin
      bat
      bat-extras.batman
      bottles
      boxbuddy
      brave
      btop
      cartridges
      collision
      curl
      direnv
      discover-overlay
      distrobox
      docker-compose
      eza
      feather
      firefox
      fragments
      freshfetch
      gcc
      gettext
      gh
      git
      git-repo
      github-desktop
      glas
      gleam
      glib
      gnome-extension-manager
      gnome.dconf-editor
      gnome.gnome-boxes
      gnome.gnome-tweaks
      gnome.polari
      gnome.seahorse
      gnumake
      goofcord
      gparted
      guake
      helvum
      home-manager
      hyfetch
      impression
      iosevka
      jamesdsp
      keepassxc
      llama-cpp
      localsend
      lutris
      magic-wormhole
      meslo-lgs-nf
      mindustry-wayland
      monophony
      mpv
      neovim
      neovim-gtk
      nix-search-cli
      nodePackages_latest.pnpm
      nodejs-slim
      onionshare-gui
      openrazer-daemon
      pavucontrol
      perl
      picard
      pika-backup
      pinentry-gnome3
      pipx
      pnpm-shell-completion
      polychromatic
      protonmail-bridge
      protonmail-bridge-gui
      protonplus
      protonvpn-gui
      ptyxis
      python3
      redis
      ripgrep
      sassc
      shattered-pixel-dungeon
      simplex-chat-desktop
      topgrade
      tor-browser
      tuckr
      usbtop
      ventoy-full
      wget
      wl-clipboard
      wlrctl
      wormhole-william
      xmrig-mo
      zoxide

    # Gnome Extensions
    ]) ++ (with pkgs.gnomeExtensions; [
        alphabetical-app-grid
        appindicator
        blur-my-shell
        burn-my-windows
        caffeine
        dash2dock-lite
        gsconnect
        logo-menu
        night-theme-switcher
        pop-shell
        quick-settings-audio-devices-renamer
        search-light
        wifi-qrcode
        wiggle
        window-title-is-back
        xwayland-indicator
        zen
      ]);
  };
  services.vsftpd.localUsers = true;

  # Misc

  ## Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  ## Enable virtualisation
  virtualisation = {
    kvmgt.enable = true;
    libvirtd.enable = true;
    docker.enable = true;
    waydroid.enable = true;
    podman.enable = true;
  };
  
  #' List packages installed in system profile. To search, run:
  #' $ nix search wget


  # Ollama
  disabledModules = 
  [
    "services/misc/ollama.nix"
    "services/web-apps/nextjs-ollama-llm-ui.nix"
  ];
  imports = 
  [
    "${inputs.unstable}/nixos/modules/services/misc/ollama.nix"
    "${inputs.unstable}/nixos/modules/services/web-apps/nextjs-ollama-llm-ui.nix"
  ];

  environment.systemPackages = with pkgs; [
    btrfs-progs
    busybox
    ecryptfs
    exfatprogs
    gcc
    git
    libvirt
    lsof
    mcron
    neovim
    pinentry-gnome3
    qemu
    qemu_kvm
    rsync
    sbctl
    steam-tui
    steamcmd
  ];

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

  security.acme.acceptTerms = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
