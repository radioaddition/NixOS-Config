{ config, pkgs, inputs, lib, ... }: {
  # Define system hostname
  networking.hostName = "framework";

  # Extend timeout of home-manager service so it doesn't fail
  systemd.services.home-manager-radioaddition.serviceConfig.TimeoutStartSec = lib.mkForce 600;

  # Enable fingerprint reader support
  services.fprintd = {
    enable = true;
    #tod = {
    #  enable = true;
    #  driver = pkgs.libfprint-2-tod1-goodix;
    #};
  };
  # Improve sound quality
  hardware.framework.laptop13.audioEnhancement = {
    enable = true;
    # Turn base speaker volume up to max before applying this
    hideRawDevice = true;
  };
}
