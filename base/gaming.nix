{ config, pkgs, inputs, lib, ... }: {
  imports = [
    inputs.jovian-nixos.nixosModules.default
  ];
  ## Steam
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    localNetworkGameTransfers.openFirewall = true;
    dedicatedServer.openFirewall = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
    extest.enable = true;
    package = pkgs.steam.override {
      withPrimus = true;
      withJava = true;
    };
  };
  programs.gamescope.enable = true;
  programs.java.enable = true; 
  hardware.openrazer.enable = true;
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic
  ];

  # Jovian
  jovian = {
    steam = {
      enable = true;
      autoStart = true;
      desktopSession = "gdm";
      updater.splash = "jovian";
      user = "radioaddition";
    };
    devices.steamdeck.enable = false;
    decky-loader.enable = true;
    steamos.useSteamOSConfig = true;
    hardware.has.amd.gpu = true;
  };
}

