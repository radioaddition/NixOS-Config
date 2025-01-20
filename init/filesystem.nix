{ lib, config, pkgs, ... }: {
  fileSystems."/" = {
    device = "/dev/mapper/crypted";
    fsType = "btrfs";
    options = [ "subvol=root" "compress=zstd" "noexec" ];
  };

  boot.initrd.postResumeCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/root_vg/root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

  fileSystems."/persistent" = {
    device = "/dev/mapper/crypted";
    neededForBoot = true;
    fsType = "btrfs";
    options = [ "subvol=persistent" "compress=zstd" "noexec"];
  };

  fileSystems."/home" = {
    device = "/dev/mapper/crypted";
    neededForBoot = true;
    fsType = "btrfs";
    options = [ "subvol=home" "compress=zstd" "noexec" ];
  };

  fileSystems."/swap" = {
    device = "/dev/mapper/crypted";
    fsType = "btrfs";
    options = [ "subvol=swap" "compress=zstd" "noexec" ];
  };
  swapDevices = [{ device = "/swap/swapfile"; label = "swap"; size = 32768; }];

  fileSystems."/nix" = {
    device = "/dev/mapper/crypted";
    fsType = "btrfs";
    options = [ "subvol=nix" "compress=zstd" ];
  };

  # be sure to define this in the host-specific configuration
  #fileSystems."/boot" = {
  #  device = "/dev/disk/by-uuid/XXXX-XXXX";
  #  fsType = "vfat";
  #};
}
