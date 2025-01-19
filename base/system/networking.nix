{ config, pkgs, inputs, lib, ... }: {

  #' Configure network proxy if necessary
  #- networking.proxy.default = "http://user:password@proxy:port/";
  #- networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  ### Configure NetworkManager

  networking.networkmanager = {
    enable = true;
    wifi = {
      macAddress = "random";
      powersave = true;
      scanRandMacAddress = true;
      backend = "iwd";
    };
  };

  ### Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 65530 51413 9052 9053 9080 53317 ];
  networking.firewall.allowedUDPPorts = [ 65530 51413 9052 9053 9080 53317 ];
  networking.firewall.allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  networking.firewall.allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];
  #' Or disable the firewall altogether.
  #' networking.firewall.enable = false;

  time.timeZone = "America/New_York";

}

