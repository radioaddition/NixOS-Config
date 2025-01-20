{ config, pkgs, inputs, lib, ... }: {
  boot = lib.mkForce {

  # Enable silent boot
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

  # Misc bootloader config
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
#      grub = {
#	enable = true;
#        efiSupport = true;
#        device = "nodev";
#        useOSProber = true;
#        timeoutStyle = "menu";
#      };
      efi.canTouchEfiVariables = true;
    };
    extraModprobeConfig = ''
      options snd-intel-dspcfg dsp_driver=1
    '';
  };
  environment.systemPackages = with pkgs; [
    btrfs-progs
    neovim
  ];

  users.users.radioaddition.packages = with pkgs; [

    # Packages
    git
    home-manager
  ];
}

