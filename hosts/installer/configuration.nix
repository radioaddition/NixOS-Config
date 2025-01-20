{ config, pkgs, inputs, lib, ... }: {

  xdg.portal = {
    enable = true;
    extraPortals = [ xdg-desktop-portal-shana ];
  };
  environment.systemPackages = with pkgs; [
    btrfs-progs
    neovim
  ];

  users.users.radioaddition.packages = with pkgs; [

    # Packages
    atuin
    bat
    bat-extras.batman
    chezmoi
    curl
    direnv
    eza
    git
    home-manager
    wget
    zoxide
  ];
}

