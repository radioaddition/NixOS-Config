{ config, lib, pkgs, ... }:

{
  # Simply install just the packages
  user.shell = "/data/data/com.termux.nix/files/home/.nix-profile/bin/zsh";
  environment.packages = with pkgs; [
    # User-facing stuff that you really really want to have
    neovim
    diffutils
    findutils
    utillinux
    tzdata
    hostname
    man
    gnugrep
    gnupg
    gnused
    gnutar
    bzip2
    gzip
    xz
    zip
    unzip
    openssh
    git
    zsh
    #gitea
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  #time.timeZone = "Europe/Berlin";
}
