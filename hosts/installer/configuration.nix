{ config, pkgs, inputs, lib, ... }: {

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

