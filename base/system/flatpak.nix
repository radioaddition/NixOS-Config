# Currently this is very small, however, I'll eventually start using the nix-flatpak flake, so since I'll need that to be it's own config file, and since I need flatpak disabled for the installer image, this is my current solution
{ pkgs, lib, config, inputs, ... }: {
  # Enable flatpak
  services.flatpak.enable = true;
}
