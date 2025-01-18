{ pkgs, config, libs, inputs, ... }:

{
  # in case of git.sr.ht outage
  #manual.html.enable = false;
  #manual.manpages.enable = false;
  #manual.json.enable = false;
  home.username = "radioaddition";
  home.homeDirectory = "/var/home/radioaddition";
  home.stateVersion = "24.05";
}
