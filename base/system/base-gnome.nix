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
}

