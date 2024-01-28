{ pkgs, config, libs, inputs, ... }:

{
  
  # Temporarily disable manapge downloading due to sr.ht outage
  # Commented because I believe they're back up but I haven't tested
  #manual.html.enable = false;
  #manual.manpages.enable = false;
  #manual.json.enable = false;


  imports = [
  ];
  home.username = "radioaddition";
  home.homeDirectory = "/home/radioaddition";
  nixpkgs.config.allowUnfree = true;
  home.sessionPath = [ "$HOME/.local/bin" "/usr/local/bin" ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      nix-gui = "nix run github:nix-gui/nix-gui";
      clearls = "clear && ls -A";
      clearn = "clear && neofetch";
      cdnix = "cd /etc/nixos";
      full_upgrade = "sudo nixos-rebuild boot --flake /etc/nixos#aspirem --upgrade --repair --install-bootloader";
      upgrade = "nix flake update";
      apply = "sudo nixos-rebuild switch --flake /etc/nixos#aspirem";
      apply-home = "home-manager switch --flake /etc/nixos/home-manager#aspirem && source ~/.zshrc";
      viflake = "nvim /etc/nixos/flake.nix";
      vinix = "nvim /etc/nixos/hosts/aspirem.nix";
      vihm = "nvim /etc/nixos/home-manager/hosts/aspirem.nix";
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
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        { name = "zsh-users/zsh-syntax-highlighting"; } # Simple plugin installation
      ];
    };
    initExtra = ''
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
'';
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.package = pkgs.nix;
  home.packages = with pkgs; [
    git
    github-desktop
    vscodium
    gettext
    glib
    python311Packages.pygobject3
    python3
    librewolf
    browsh
    strawberry
    picard
    armcord
    lutris
    protontricks
    wineWowPackages.waylandFull
    gnome.gnome-tweaks
    mindustry-wayland
    shattered-pixel-dungeon
    rat-king-adventure
    rkpd2
    summoning-pixel-dungeon
    shorter-pixel-dungeon
    experienced-pixel-dungeon
    keepassxc
    ventoy-full
    onionshare-gui
    tor-browser
    inputs.unstable.legacyPackages.${pkgs.system}.valent
    fragments
    gimp-with-plugins
    helvum
    pavucontrol
    noisetorch
    cinny-desktop

    # GNOME extensions
    gnomeExtensions.another-window-session-manager
    gnomeExtensions.caffeine
    gnomeExtensions.dash2dock-lite
    gnomeExtensions.fullscreen-to-empty-workspace
    gnomeExtensions.search-light
    gnomeExtensions.firefox-pip-always-on-top
    gnomeExtensions.user-themes
    gnomeExtensions.alphabetical-app-grid
    gnome-browser-connector
    gnomeExtensions.paperwm
    gnomeExtensions.suppress-startup-animation
    gnomeExtensions.appindicator
    inputs.unstable.legacyPackages.${pkgs.system}.gnomeExtensions.valent
    gnomeExtensions.quick-settings-audio-devices-renamer
  ];
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "23.11";
}
