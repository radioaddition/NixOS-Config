{ config, pkgs, inputs, lib, ... }: {

  environment.systemPackages = with pkgs; [
    btrfs-progs
    busybox
    exfatprogs
    gcc
    git
    libvirt
    lsof
    mcron
    neovim
    #pinentry-gnome3
    qemu
    qemu_kvm
    rsync
    sbctl
    steam-tui
    steamcmd
  ];

  users.users.radioaddition.packages = with pkgs; [

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
    chezmoi
    collision
    curl
    dconf-editor
    direnv
    discover-overlay
    distrobox
    docker-compose
    eza
    fastfetch
    fragments
    gcc
    gettext
    git
    git-repo
    glas
    gleam
    glib
    gnome-boxes
    gnome-extension-manager
    gnome-tweaks
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
    llama-cpp
    localsend
    lutris
    magic-wormhole
    mindustry-wayland
    miracode
    monocraft
    mpv
    neovim
    onionshare-gui
    openrazer-daemon
    pavucontrol
    perl
    picard
    pika-backup
    polari
    polychromatic
    protonmail-bridge
    protonmail-bridge-gui
    protonplus
    protonvpn-gui
    ptyxis
    python3
    redis
    ripgrep
    seahorse
    shattered-pixel-dungeon
    simplex-chat-desktop
    topgrade
    tor-browser
    usbtop
    wget
    wl-clipboard
    wlrctl
    wormhole-william
    zoxide
  ];

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

}

