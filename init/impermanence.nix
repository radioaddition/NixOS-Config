{
  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/var/lib/usbguard/rules.conf"
      "/etc/secureboot"
      #{ file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
  };
}
