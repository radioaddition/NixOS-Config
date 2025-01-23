{ config, pkgs, inputs, lib, ... }: {
  services.xserver.enable = true;

  ### Enable the GNOME Desktop Environment.
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [pkgs.gnome.mutter];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['variable-refresh-rate', 'scale-monitor-framebuffer']
      '';
    };
  };
  environment.gnome.excludePackages = with pkgs; [
    yelp
    cheese
    simple-scan
    totem
    gnome-tour
    gnome-software
    gnome-weather
    epiphany
  ];

  ### Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };
    # GNOME Extensions
  users.users.radioaddition.packages = (with pkgs.gnomeExtensions; [
    alphabetical-app-grid
    #appindicator
    blur-my-shell
    caffeine
    dash-to-dock
    gsconnect
    logo-menu
    night-theme-switcher
    pop-shell
    quick-settings-audio-devices-renamer
    reboottouefi
    reorder-workspaces
    resolution-and-refresh-rate-in-quick-settings
    respect-do-not-disturb
    search-light
    space-bar
    systemd-manager
    tailscale-qs
    tray-icons-reloaded
    trimmer
    unpanel
    #valent
    wifi-qrcode
    wiggle
    window-desaturation
    window-title-is-back
    xwayland-indicator
    zen
  ]) ++ (with pkgs; [
    pop-launcher
  ]);
}

