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
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      clearls = "clear && ls -A";
      clearn = "clear && neofetch";
      claer = "clear";
      lsa = "ls -A";
      cdnix = "cd /etc/nixos";
      archive = "tar -czvf tarball.tar.gz ";
      extract = "tar -xzvf ";
      full_upgrade = "sudo nixos-rebuild boot --flake /etc/nixos#aspirem --upgrade --repair --install-bootloader";
      update = "nix flake update";
      upgrade = "sudo nixos-rebuild switch --flake /etc/nixos#aspirem --upgrade";
      apply = "sudo nixos-rebuild switch --flake /etc/nixos#aspirem";
      apply-home = "home-manager switch --flake /etc/nixos#aspirem && source ~/.zshrc";
      viflake = "nvim /etc/nixos/flake.nix";
      vinix = "nvim /etc/nixos/hosts/aspirem.nix";
      vihm = "nvim /etc/nixos/home-manager/hosts/aspirem.nix";
      vivi = "nvim /home/radioaddition/.config/nvim/init.vim";
      themeconf = "p10k configure && mv ~/.p10k.zsh /etc/nixos/home-manager/";
      clean = "nix-env --delete-generations old && nix-collect-garbage -d";
      cleanr = "sudo nix-env --delete-generations old && sudo nix-collect-garbage -d";
      commit = "git commit -a";
      push = "git push origin main";
      pushl = "git push local main";
    };
    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-autosuggestions kind:defer"
	"zdharma-continuum/fast-syntax-highlighting kind:defer"
	"zsh-users/zsh-history-substring-search kind:defer"
	"getantidote/use-omz"
	"ohmyzsh/ohmyzsh path:lib"
	"ohmyzsh/ohmyzsh path:plugins/extract"
	"rupa/z"
	"sindresorhus/pure"
      ];
    };
    initExtra = ''
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
'';
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.package = pkgs.nix;
  home.packages = with pkgs; [
    github-desktop
    home-manager
    vscodium
    gettext
    glib
    python311Packages.pygobject3
    python3
    librewolf
    strawberry
    picard
    goofcord
    lutris
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
    fragments
    gimp-with-plugins
    helvum
    pavucontrol
    noisetorch
    cinny-desktop
    bookworm
    libreoffice-fresh

    # GNOME extensions
    gnomeExtensions.caffeine
    gnomeExtensions.dash2dock-lite
    gnomeExtensions.search-light
    gnomeExtensions.user-themes
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.appindicator
    gnomeExtensions.quick-settings-audio-devices-renamer
    gnomeExtensions.gsconnect

    # Hyprland apps
    hyprdim
    hyprshot
    hyprnome
    hyprlang
    hyprkeys
    hyprutils
    hyprshade
    hyprpaper
    hyprpicker
    hyprcursor
    
    # nwg-shell
    nwg-bar
    nwg-menu
    nwg-look
    nwg-dock-hyprland
    nwg-panel
    nwg-hello
    nwg-drawer
    nwg-displays
    nwg-launchers
  ];
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.05";
}
