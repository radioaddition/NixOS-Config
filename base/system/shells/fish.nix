{ config, pkgs, inputs, lib, ... }: {
  ## Enable fish
  programs.fish.enable = true;
  programs.fish.useBabelfish = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = [ pkgs.fish ];
}
