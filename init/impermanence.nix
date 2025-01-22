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
      { directory = "/home/radioaddition"; user = "radioaddition"; group = "radioaddition"; mode = "u=rw,g=r,o="; }
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      #"/etc/machine-id"
      #{ file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
  };
  #environment.persistence."/home" = {
  #  enable = true;
  #  hideMounts = true;
  #  users.radioaddition = {
  #    directories = [
  #      "Downloads"
  #      "Music"
  #      "Pictures"
  #      "Documents"
  #      "Videos"
  #      { directory = ".gnupg"; mode = "0700"; }
  #      { directory = ".ssh"; mode = "0700"; }
  #      { directory = ".nixops"; mode = "0700"; }
  #      { directory = ".local/share/keyrings"; mode = "0700"; }
  #      ".local/share/direnv"
  #      ".config"
  #      ".local"
  #    ];
  #    files = [
  #    ];
  #  };
  #};
}
