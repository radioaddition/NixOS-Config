{ pkgs, config, libs, inputs, ... }:

{
  
  # in case of git.sr.ht outage
  #manual.html.enable = false;
  #manual.manpages.enable = false;
  #manual.json.enable = false;


  imports = [
  ];
  news.display = "silent";
  home.username = "nix-on-droid";
  home.homeDirectory = "/home/nix-on-droid";
  nixpkgs.config.allowUnfree = true;
  home.sessionPath = [ "$HOME/.local/bin" "/usr/local/bin" ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      clearls = "clear && ls -A";
      clearn = "clear && neofetch";
      cdnix = "cd /etc/nixos";
      full_upgrade = "sudo nixos-rebuild boot --flake /etc/nixos#aspirem --upgrade --repair --install-bootloader";
      update = "nix flake update";
      upgrade = "sudo nixos-rebuild switch --flake /etc/nixos#aspirem --upgrade";
      apply = "sudo nixos-rebuild switch --flake /etc/nixos#aspirem";
      apply-home = "home-manager switch --flake /etc/nixos#aspirem && source ~/.zshrc";
      viflake = "nvim $HOME/.config/nix-on-droid/flake.nix";
      vinix = "nvim $HOME/.config/nix-on-droid/hosts/pixel6.nix";
      vihm = "nvim $HOME/.config/nix-on-droid/home-managee/hosts/pixel6.nix";
      clean = "nix-env --delete-generations old && nix-collect-garbage -d";
      cleanr = "sudo nix-env --delete-generations old && sudo nix-collect-garbage -d";
      commit = "git commit -a";
      push = "git push origin main";
      pushl = "git push local main";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        { name = "zsh-users/zsh-syntax-highlighting"; } # Simple plugin installation
      ];
    };
    initExtra = ''
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
'';
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.package = pkgs.nix;
  home.packages = with pkgs; [
    git
    gettext
    glib
    home-manager
  ];
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "23.11";
}
