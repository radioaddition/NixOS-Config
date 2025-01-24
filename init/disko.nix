{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/some-disk"; # When using disko-install, this will be overwritten from the commandline
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "5G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings.allowDiscards = true;
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "root" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd" "noatime" "noexec" ];
                    };
                    "persistent" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd" "noatime" "noexec" ];
                    };
                    "home" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=zstd" "noatime" "noexec" ];
                    };
                    "nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "32G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
