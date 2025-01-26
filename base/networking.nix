{ config, pkgs, inputs, lib, ... }: {

  #' Configure network proxy if necessary
  #- networking.proxy.default = "http://user:password@proxy:port/";
  #- networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # NetworkManager
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    wifi = {
      macAddress = "random";
      #powersave = true;
      #backend = "iwd";
    };
  };

  #environment.systemPackages = with pkgs; [
  #  #dhcpcd
  #  iwgtk
  #];

  # systemd-resolved
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];
  services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "true";
    domains = [ "~." ];
    #llmnr = "true";
    fallbackDns = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };

  # Tailscale
  services.tailscale = {
    enable = true;
  };

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [
      65530
      51413
      9052
      9053
      9080
      53317
    ];
    allowedUDPPorts = [
      65530
      51413
      9052
      9053
      9080
      53317
    ];
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];
    trustedInterfaces = [
      "tailscale0"
    ];
  };
  #' Or disable the firewall altogether.
  #' networking.firewall.enable = false;

  time.timeZone = "America/New_York";

}

