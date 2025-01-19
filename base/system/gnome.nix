{ config, pkgs, inputs, lib, ... }: {
  ### Enable the X11 windowing system.
  services.xserver.enable = true;

  ### Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs.gnome; [
    yelp
    cheese
    simple-scan
    totem
  ];

  ### Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };
    # GNOME Extensions
  users.users.radioaddition.packages = with pkgs.gnomeExtensions; [
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
  ];
}

