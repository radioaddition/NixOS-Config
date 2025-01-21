{ pkgs, config, libs, inputs, ... }: {

  imports = [
    ./base/hm/gnome-extensions.nix
    ./base/hm/home.nix
    ./base/hm/shells/fish.nix
  ];
  # in case of git.sr.ht outage
  #manual.html.enable = false;
  #manual.manpages.enable = false;
  #manual.json.enable = false;
  home.username = "radioaddition";
  home.homeDirectory = "/home/radioaddition";
  home.stateVersion = "24.11";
}
