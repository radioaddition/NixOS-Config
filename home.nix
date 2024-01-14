{ pkgs, config, libs, ... }:

let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixos-unstable)
    # reuse the current configuration
    { config = config.nixpkgs.config; };
in {
  imports = [
  ];
  home.username = "radioaddition";
  home.homeDirectory = "/home/radioaddition";
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
      full_update = "sudo nixos-rebuild boot --upgrade --repair --install-bootloader";
      update = "sudo nixos-rebuild switch --upgrade";
      apply = "sudo nixos-rebuild switch";
      vinix = "sudo nvim /etc/nixos/configuration.nix";
      vihm = "nvim /home/radioaddition/.config/home-manager/home.nix";
      vivi = "nvim /home/radioaddition/.config/nvim/init.vim";
      clean = "nix-env --delete-generations old && nix-collect-garbage -d";
      cleanr = "sudo nix-env --delete-generations old && sudo nix-collect-garbage -d";
      apply-home = "home-manager switch && source /home/radioaddition/.zshrc && ln -sf ~/.nix-profile/share/applications/* ~/.local/share/applications";
      nix = "nix --extra-experimental-features nix-command --extra-experimental-features flakes";
      sync = "rsync -a --delete --no-links --progress /etc/nixos /run/media/radioaddition/Ventoy/storage/dotfiles && rsync -a --delete --no-links --progress /home/radioaddition/.config /run/media/radioaddition/Ventoy/Storage/dotfiles && rsync -a --delete --no-links --progress /home/radioaddition/Music /run/media/radioaddition/Ventoy/Storage && rsync -a --delete --no-links --progress /home/radioaddition/.librewolf /run/media/radioaddition/Ventoy/Storage/dotfiles && rsync -a --delete --no-links --progress /home/radioaddition/.local /run/media/radioaddition/Ventoy/storage/dotfiles";
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
  home.packages = with pkgs; [
    git
  ];
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "23.11";
}
