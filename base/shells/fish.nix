{ pkgs, config, libs, inputs, ... }: {

  home.sessionPath = [ "$HOME/.local/bin" "$HOME/bin" "$HOME/.cargo/bin" "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" "/var/home/linuxbrew/.linuxbrew/Cellar/zplug/2.4.2/bin" "$HOME/.nix-profile/bin" ];
  programs.fish = {
    enable = true;
    shellAliases = {
      clearls = "clear && ls -A";
      archive = "tar -czvf archive.tar.gz ";
      extract = "tar -xzvf ";
      vivi = "nvim /home/radioaddition/.config/nvim/init.vim";
      clean = "nix-env --delete-generations old && nix-collect-garbage -d && nix profile wipe-history";
      cleanr = "run0 sh -c 'nix-env --delete-generations old && nix-collect-garbage -d && nix profile wipe-history'";
      so = "exec fish";
    };
    shellInit = ''
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

      eval "$(atuin init fish)"
      eval "$(direnv hook fish)"
      eval "$(starship init fish)"
      eval "$(chezmoi completion fish)"
      eval "$(just --completions fish)"
'';
  };
  programs.zoxide.enable = true;
  programs.thefuck.enable = true;
  programs.starship = {
    enable = true;
    # If I ever decide I don't like the default config
    #settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    #};
  };

  # Atuin
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      update_check = false;
      filter_mode = "session";
      workspaces = true;
      style = "auto";
      exit_mode = "return-query";
      ctrl_n_shortcuts = false;
      enter_accept = true;
      keymap_mode = "vim-insert";
    };
  };
  programs.yazi.enableFishIntegration = true;
  programs.thefuck.enable = true;
}
