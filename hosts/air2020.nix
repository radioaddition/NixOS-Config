{ pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  # Configure nix
  nix = {
    settings = {
      auto-optimise-store = true;
    };
    extraOptions = "extra-experimental-features = nix-command flakes";
  };
  # Configure system packages
  environment.systemPackages = with pkgs; [
    neovim
    git
    home-manager
    wget
    curl
    neofetch
    rsync
    syncthing
    qemu
    qemu_kvm
    libvirt
    virt-manager
    podman
    podman-tui
    android-tools
  ];

  # Configure lorri
  services.lorri = {
    enable = true;
  };

  # Configure yabai
  # services.yabai = {
    # enable = true;
    # config = {
      # focus_follows_mouse         = "autoraise";
      # mouse_modifier              = "cmd";
      # layout                      = "bsp";
      # window_placement            = "second_child";
      # window_opacity              = "on";
      # window_opacity_duration     = 0.2;
      # active_window_opacity       = 1.0;
      # normal_window_opacity       = 0.5;
      # top_padding                 = 36;
      # bottom_padding              = 10;
      # left_padding                = 10;
      # right_padding               = 10;
      # window_gap                  = 10;
      # auto_padding                = "on";
      # window_shadow               = "float";
    # };

  # };

  # Configure skhd
  services.skhd = {
    enable = true;
    skhdConfig = ''
      lalt - j    : yabai -m window --focus west  || yabai -m display --focus west
      lalt - k    : yabai -m window --focus south || yabai -m display --focus south
      lalt - l    : yabai -m window --focus north || yabai -m display --focus north
      lalt - h    : yabai -m window --focus east  || yabai -m display --focus east
      lalt - t    : terminal msg create-window
    '';
  };

  # Configure zsh
  programs.zsh.enable = true;
#  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  # Refer to /Users/radioaddition/.config/home-manager/home.nix for the rest of the configuration

  # Configure homebrew
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
    brews = [
      "gettext"
      "glib"
      "duf"
      "diskonaut"
      "diskus"
      "go"
      "make"
      "gsl"
      "llvm"
      "boost"
      "wget"
      "mas"
      "switchaudio-osx"
      "borders"
      "cryfs"
    ];
    casks = [
      "android-commandlinetools"
      "github"
      "librewolf"
      "the-unarchiver"
      "bartender"
      "keepassxc"
      "syncthing"
      "jitsi-meet"
      "temurin"
      "utm"
      "libreoffice"
      "meetingbar"
      "geany"
      "background-music"
      "vimr"
      "uninstallpkg"
      "sf-symbols"
      "font-hack-nerd-font"
      "font-jetbrains-mono"
      "font-fira-code"
    ];
    taps = [
      "homebrew/cask-fonts"
      "FelixKratz/formulae"
      "koekeishiya/formulae"
    ];
    #whalebrews = [
      #""
    #];
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  nixpkgs.hostPlatform = "x86_64-darwin";
  system.stateVersion = 4;
}
