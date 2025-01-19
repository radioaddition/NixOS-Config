{ config, pkgs, inputs, lib, ... }: {

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

