{ config, pkgs, inputs, lib, ... }: {

  # AppArmor
  services.dbus.apparmor = "enabled";
  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = true;
    enableCache = true;
  };

  # Enable GnuPG
  services.pcscd.enable = true;
  programs.gnupg.agent = {
   enable = true;
   pinentryPackage = pkgs.pinentry-gnome3;
   enableSSHSupport = true;
  };

  # Restrict Nix access
  nix.settings.allowed-users = [ "@nix" ];

  # Disable sudo in favor of run0
  # security.sudo.enable = false; # disable this setting while testing in kvm due to run0 not working properly in a vm

  # Yubikey Pam login
  security.pam.yubico = {
   enable = true;
   mode = "challenge-response";
   id = [ "27725426" ];
  };
  # Lock device upon removal
  #services.udev.extraRules = ''
      #ACTION=="remove",\
       #ENV{ID_BUS}=="usb",\
       #ENV{ID_MODEL_ID}=="0407",\
       #ENV{ID_VENDOR_ID}=="1050",\
       #ENV{ID_VENDOR}=="Yubico",\
       #RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  #'';

  # Disable CUPS
  services.printing.enable = false;

}
