{ lib, config, pkgs, ... }: {

  fileSystems."/" = {
    device = "/dev/disk/by-partlabel/disk-main-root";
    neededForBoot = true;
    fsType = "btrfs";
    options = [
      "subvol=root"
      "compress=zstd"
      "nosuid"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/mapper/crypted";
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "compress=zstd"
    ];
  };
}
