{ config, pkgs, inputs, lib, ... }: {
  ## Enable fish
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = [ pkgs.fish ];
}
