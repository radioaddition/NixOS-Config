{ config, pkgs, inputs, lib, ... }: {
  ## Steam
  programs.steam = {
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    localNetworkGameTransfers.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extest.enable = true;
    enable = true;
    #-package = pkgs.steam.override {
      #-withPrimus = true;
      #-extraPackages = pkgs: [ bumblebee glxinfo ];
      #-withJava = true;
    #-};
  };
  programs.gamescope.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.java.enable = true; 
  #hardware.openrazer.enable = true;
}

