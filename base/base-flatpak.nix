{ lib, config, pkgs, flake-inputs, ... }: {
  # Import nix-flatpak module
  imports = [ flake-inputs.flatpaks.homeManagerModules.nix-flatpak ];
  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    update.auto = {
      enable = true;
      onCalendar = "daily";
    };
    remotes = [
      { name = "flathub-verified"; subset = "verified"; location = "https://flathub.org/repo/flathub.flatpakrepo"; };
      { name = "flathub"; location = "https://flathub.org/repo/flathub.flatpakrepo"; };
    ];
    packages = [
    # Set either with just the appID in quotes ("com.app.app") or with the app/remote/etc in {} ({ appId = "com.app.app"; origin = "remote";  })
    ];
  };
}
