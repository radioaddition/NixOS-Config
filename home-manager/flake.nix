{
  description = "Home Manager configuration of radioaddition";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

  outputs = { self, nixpkgs, home-manager, unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      home-config = 

{ pkgs, config, libs, inputs, ... }:

{
  
  # Temporarily disable manapge downloading due to sr.ht outage
  manual.html.enable = false;
  manual.manpages.enable = false;
  manual.json.enable = false;


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
      clearls = "clear && ls -A";
      clearn = "clear && neofetch";
      full_update = "sudo nixos-rebuild boot --upgrade --repair --install-bootloader";
      update = "sudo nixos-rebuild switch --upgrade";
      apply = "sudo nixos-rebuild switch --flake /etc/nixos#RadioAddition";
      apply-home = "home-manager switch --flake /etc/nixos/home-manager && source ~/.zshrc";
      vinix = "nvim /etc/nixos/flake.nix";
      vihm = "nvim /etc/nixos/home-manager/flake.nix";
      vivi = "nvim /home/radioaddition/.config/nvim/init.vim";
      clean = "nix-env --delete-generations old && nix-collect-garbage -d";
      cleanr = "sudo nix-env --delete-generations old && sudo nix-collect-garbage -d";
      nix = "nix --extra-experimental-features nix-command --extra-experimental-features flakes";
      sync = "rsync -a --delete --no-links --progress /etc/nixos /run/media/radioaddition/Ventoy/storage/dotfiles && rsync -a --delete --no-links --progress /home/radioaddition/.config /run/media/radioaddition/Ventoy/Storage/dotfiles && rsync -a --delete --no-links --progress /home/radioaddition/Music /run/media/radioaddition/Ventoy/Storage && rsync -a --delete --no-links --progress /home/radioaddition/.librewolf /run/media/radioaddition/Ventoy/Storage/dotfiles && rsync -a --delete --no-links --progress /home/radioaddition/.local /run/media/radioaddition/Ventoy/storage/dotfiles";
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
};

    in {
      homeConfigurations."radioaddition" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
	    extraSpecialArgs = {inherit inputs;};
        modules = [ home-config ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
