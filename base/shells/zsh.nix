{ pkgs, config, libs, inputs, ... }: {

  home.sessionPath = [ "$HOME/.local/bin" "$HOME/bin" "$HOME/.cargo/bin" "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" "/var/home/linuxbrew/.linuxbrew/Cellar/zplug/2.4.2/bin" "$HOME/.nix-profile/bin" ];
  programs.zsh = {
    enable = true;
    # Zprof will profile your zsh startup time
    # zprof.enable = true;
    shellAliases = {
      clearls = "clear && ls -A";
      archive = "tar -czvf archive.tar.gz ";
      extract = "tar -xzvf ";
      vivi = "nvim /home/radioaddition/.config/nvim/init.vim";
      clean = "nix-env --delete-generations old && nix-collect-garbage -d && nix profile wipe-history";
      cleanr = "run0 sh -c 'nix-env --delete-generations old && nix-collect-garbage -d && nix profile wipe-history'";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "jeffreytse/zsh-vi-mode"; }
      ];
    };
    history = {
      ignoreAllDups = true;
      extended = true;
    };
    initExtra = ''
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

      eval "$(atuin init zsh)"
      eval "$(direnv hook zsh)"
      eval "$(starship init zsh)"
      eval "$(chezmoi completion zsh)"
      eval "$(just --completions zsh)"
'';
  };
  programs.zoxide.enable = true;
  programs.starship.enable = true;

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
      keymap_cursor = {
        emacs = "blink-block";
	vim_insert = "blink-line";
	vim_normal = "steady-block";
      };
    };
  };
}
