{ pkgs, config, libs, inputs, ... }:

{
  
  # in case of git.sr.ht outage
  #manual.html.enable = false;
  #manual.manpages.enable = false;
  #manual.json.enable = false;


  imports = [
  ];
  #news.display = "silent";
  # Commented out because this can occasionally be different (ie some of my hosts have multiple users, and some are on Fedora/RHEL based (which uses /var/home)) but I need to be reminded to set it per host
  #home.username = "radioaddition";
  #home.homeDirectory = "/home/radioaddition";

  nixpkgs.config.allowUnfree = true;
  home.sessionVariables = {
    EDITOR = "nvim";
    DBX_CONTAINER_MANAGER = "podman";
  };

  # Direnv
  programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
  };
  nix.package = pkgs.nixVersions.stable;
  home.packages = with pkgs; [

  # Packages
    atuin
    bat
    btop
    chezmoi
    curl
    direnv
    eza
    freshfetch
    gh
    git-repo
    glas
    gleam
    gparted
    home-manager
    hyfetch
    iosevka
    just
    meslo-lgs-nf
    monophony
    mpv
    neovim
    nodePackages_latest.pnpm
    pipx
    python3
    starship
    topgrade
    usbtop
#    docker-compose
#    gcc
#    gettext
#    git
#    github-desktop
#    glib
#    gnumake
#    guake
#    jamesdsp
#    llama-cpp
#    mindustry-wayland
#    neovim-gtk
#    nodejs-slim
#    onionshare-gui
#    openrazer-daemon
#    pavucontrol
#    perl
#    pinentry-gnome3
#    polychromatic
#    protonvpn-gui
#    redis
#    shattered-pixel-dungeon
#    wget
#    wl-clipboard
#    wlrctl
#    xmrig-mo

    ];

  #home.enableNixpkgsReleaseCheck = false; # If using a package from the unstable branch uncomment this
}
