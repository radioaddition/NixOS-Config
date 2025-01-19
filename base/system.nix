{ config, pkgs, inputs, lib, ... }: {

  ### Set nix version to latest
  nix.package = pkgs.nixVersions.latest;

  ### Auto Updates
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--no-write-lock-file"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  ## Bootloader
  boot = {

  ### Boot animation
    plymouth = {
      enable = true;
      theme = "cuts_alt";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "cuts_alt" ];
        })
      ];
    };

  ### Enable silent boot
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

  ### Misc bootloader config
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
    kernelModules = [ "ecryptfs" ];
    extraModprobeConfig = ''
      options snd-intel-dspcfg dsp_driver=1
    '';
  };

  hardware.enableAllFirmware = true;

  ### Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  ## Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #' If you want to use JACK applications, uncomment this
    jack.enable = true;

    #' use the example session manager (no others are packaged yet so this is enabled by default,
    #' no need to redefine it in your config for now)
    wireplumber.enable = true;
  };

  ## Enable ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];

  ## Enable flake support
  nix = {
    settings = {
      auto-optimise-store = true;
      warn-dirty = false;
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  ## Enable flatpak
  services.flatpak.enable = true;

  ## Enable ADB/Fastboot
  programs.adb.enable = true;
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}

