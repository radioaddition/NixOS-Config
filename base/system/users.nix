{ config, pkgs, inputs, lib, ... }: {
  users.users.radioadmin = {
    isNormalUser = true;
    description = "RadioAdmin";
    extraGroups = [ "adbusers" "docker" "kvm" "libvirt" "libvirtd" "lxd" "networkmanager" "openrazer" "wheel" "nix" ];
    # Change this password on an actual system!!
    hashedPassword = "$y$j9T$gMRIRcus7uO1X6zrPTfVn/$0iOFINi8HZPH5b0QpXXCQbanUwYe9lpzjD17NbitD39";
  };
  users.users.radioaddition = {
    isNormalUser = true;
    description = "RadioAddition";
    extraGroups = [ "adbusers" "docker" "kvm" "libvirt" "libvirtd" "lxd" "networkmanager" "openrazer" "nix" ];
    # Change this password on an actual system!!
    hashedPassword = "$y$j9T$gMRIRcus7uO1X6zrPTfVn/$0iOFINi8HZPH5b0QpXXCQbanUwYe9lpzjD17NbitD39";
  };
  services.vsftpd.localUsers = true;
}
