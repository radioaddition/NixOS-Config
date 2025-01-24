{ lib, config, pkgs, ... }: {

  boot.initrd.luks.devices."crypted" = {
    device = "/dev/disk/by-partlabel/disk-main-luks";
    crypttabExtraOpts = [ "tpm2-device=auto" "tpm2-measure-pcr=yes" ];
  };

  fileSystems."/" = {
    device = "/dev/mapper/crypted";
    neededForBoot = true;
    fsType = "btrfs";
    options = [
      "subvol=root"
      "compress=zstd"
      "exec"
      "nosuid"
    ];
  };

  fileSystems."/persistent" = {
    device = "/dev/mapper/crypted";
    neededForBoot = true;
    fsType = "btrfs";
    options = [
      "subvol=persistent"
      "compress=zstd"
      "noexec"
      "nosuid"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/mapper/crypted";
    neededForBoot = true;
    fsType = "btrfs";
    options = [
      "subvol=home"
      "compress=zstd"
      "noexec"
      "nosuid"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/mapper/crypted";
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "compress=zstd"
      "exec"
    ];
  };

  fileSystems."/swap" = {
    device = "/dev/mapper/crypted";
    fsType = "btrfs";
    options = [
      "subvol=swap"
      "compress=zstd"
      "noexec"
      "nosuid"
    ];
  };
  swapDevices = [{ device = lib.mkForce "/swap/swapfile"; label = "swap"; size = 32768; }];

  boot.initrd.postResumeCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/mapper/crypted /btrfs_tmp
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

  # be sure to define this in the host-specific configuration
  #fileSystems."/boot" = {
  #  device = "/dev/disk/by-uuid/XXXX-XXXX";
  #  fsType = "vfat";
  #};
}
