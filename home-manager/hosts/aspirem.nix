{ pkgs, config, libs, inputs, ... }:

{
  
  # in case of git.sr.ht outage
  #manual.html.enable = false;
  #manual.manpages.enable = false;
  #manual.json.enable = false;


  imports = [
  ];
  news.display = "silent";
  home.username = "radioaddition";
  home.homeDirectory = "/home/radioaddition";
  nixpkgs.config.allowUnfree = true;
  home.sessionPath = [ "$HOME/.local/bin" "/usr/local/bin" ];
  home.sessionVariables = {
    EDITOR = "nvim";
    DBX_CONTAINER_MANAGER = "podman";
  };
  # GPG
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  # Syncthing
  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  # ZSH
  programs.zsh = {
    enable = true;
    shellAliases = {
      clearls = "clear && ls -A";
      ls = "lsd -A";
      archive = "tar -czvf archive.tar.gz ";
      extract = "tar -xzvf ";
      update = "nix flake update";
      upgrade = "sudo nixos-rebuild switch --flake ./#aspirem --upgrade";
      apply = "sudo nixos-rebuild switch --flake ./#aspirem";
      apply-home = "home-manager switch --flake ./#aspirem && source ~/.zshrc";
      vivi = "nvim /home/radioaddition/.config/nvim/init.vim";
      clean = "nix-env --delete-generations old && nix-collect-garbage -d";
      cleanr = "sudo nix-env --delete-generations old && sudo nix-collect-garbage -d";
      commit = "git commit -a";
      push = "git push origin main";
      pushl = "git push local main";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "jeffreytse/zsh-vi-mode"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
    initExtra = ''
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

. ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source $HOME/NixOS-Config/home-manager/.p10k.zsh
eval "$(atuin init zsh)"
'';
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.package = pkgs.nix;
  home.packages = (with pkgs; [

  # Packages

    atuin
    bat
    bottles
    boxbuddy
    btop
    cinny-desktop
    collision
    curl
    distrobox
    docker-compose
    feather
    firefox
    fragments
    freshfetch
    gcc
    gettext
    git
    git-repo
    github-desktop
    glas
    gleam
    glib
    gnome.dconf-editor
    gnome.gnome-boxes
    gnome.gnome-tweaks
    gnome.polari
    gnome.seahorse
    gnumake
    goofcord
    gparted
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    gradience
    guake
    helvum
    home-manager
    hyfetch
    impression
    jamesdsp
    keepassxc
    kitty
    kleopatra
    librewolf
    lsd
    lutris
    mindustry-wayland
    monophony
    mpv
    neovim-gtk
    nodePackages_latest.pnpm
    nodejs-slim
    onionshare-gui
    pavucontrol
    picard
    pinentry-gnome3
    pipx
    pnpm-shell-completion
    ptyxis
    python3
    redis
    shattered-pixel-dungeon
    simplex-chat-desktop
    tor-browser
    tuckr
    usbtop
    ventoy-full
    vscodium
    wget
    wl-clipboard
    xmrig-mo
    yubikey-touch-detector
    zed-editor

  # Gnome Extensions
  ]) ++ (with pkgs.gnomeExtensions; [
      alphabetical-app-grid
      appindicator
      blur-my-shell
      caffeine
      dash2dock-lite
      gsconnect
      logo-menu
      pano
      pop-shell
      proton-vpn-button
      quick-settings-audio-devices-renamer
      search-light
      user-themes
      wifi-qrcode
      wiggle
      window-on-top
      window-title-is-back
      workspace-isolated-dash
      xwayland-indicator
      zen
      ]);
  #home.enableNixpkgsReleaseCheck = false; # If using a package from the unstable branch uncomment this
  home.stateVersion = "24.05";
}
