{ pkgs, config, libs, ... }:
{
  imports = [
  ];
  home.username = "radioaddition";
  home.homeDirectory = "/Users/radioaddition";
  home.sessionPath = [ "$HOME/.local/bin" "/usr/local/bin" ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      clearls = "clear && ls -A";
      clearn = "clear && neofetch";
      lsa = "ls -A";
      vinix = "nvim $HOME/.config/nix-darwin/flake.nix";
      vihm = "nvim /Users/radioaddition/.config/home-manager/home.nix";
      vivi = "nvim /Users/radioaddition/.config/nvim/init.vim";
      apply = "darwin-rebuild switch --flake /Users/radioaddition/.config/nix-darwin#air2020";
      update = "darwin-rebuild switch --upgrade --flake /Users/radioaddition/.config/nix-darwin";
      apply-home = "home-manager switch && source /Users/radioaddition/.zshrc";
      repair = "sudo nix-store --repair --verify --check-contents";
      push = "git push";
      pushl = "git push local main";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        { name = "zsh-users/zsh-syntax-highlighting"; } # Simple plugin installation
	    { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };
    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      clear
    '';
    initExtra = ''
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

. ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source /Users/radioaddition/.p10k.zsh
'';
  };
  home.packages = with pkgs; [
    git
    neovim
    neofetch
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "23.11";
}
