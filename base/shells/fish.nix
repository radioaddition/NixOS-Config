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
# Apply home.sessionPath and home.sessionVariables if set
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

      # Colors (copy + pasted from the webui output)
      SETUVAR __fish_initialized:3400
      SETUVAR fish_color_autosuggestion:666
      SETUVAR fish_color_cancel:\x2d\x2dreverse
      SETUVAR fish_color_command:00ff00
      SETUVAR fish_color_comment:888\x1e\x2d\x2ditalics
      SETUVAR fish_color_cwd:0A0
      SETUVAR fish_color_cwd_root:A00
      SETUVAR fish_color_end:ffff00
      SETUVAR fish_color_error:F22
      SETUVAR fish_color_escape:0AA
      SETUVAR fish_color_history_current:0AA
      SETUVAR fish_color_host:normal
      SETUVAR fish_color_host_remote:\x1d
      SETUVAR fish_color_keyword:\x1d
      SETUVAR fish_color_match:0AA
      SETUVAR fish_color_normal:B2B2B2
      SETUVAR fish_color_operator:0AA
      SETUVAR fish_color_option:\x1d
      SETUVAR fish_color_param:0087d7
      SETUVAR fish_color_quote:ffd75f
      SETUVAR fish_color_redirection:00ffd7
      SETUVAR fish_color_search_match:\x2d\x2dbackground\x3d533
      SETUVAR fish_color_selection:\x2d\x2dbackground\x3dB218B2
      SETUVAR fish_color_status:red
      SETUVAR fish_color_user:brgreen
      SETUVAR fish_color_valid_path:\x2d\x2dunderline
      SETUVAR fish_key_bindings:fish_default_key_bindings
      SETUVAR fish_pager_color_background:\x1d
      SETUVAR fish_pager_color_completion:BBB
      SETUVAR fish_pager_color_description:666
      SETUVAR fish_pager_color_prefix:0AA\x1e\x2d\x2dunderline
      SETUVAR fish_pager_color_progress:0AA
      SETUVAR fish_pager_color_secondary_background:\x1d
      SETUVAR fish_pager_color_secondary_completion:\x1d
      SETUVAR fish_pager_color_secondary_description:\x1d
      SETUVAR fish_pager_color_secondary_prefix:\x1d
      SETUVAR fish_pager_color_selected_background:\x2d\x2dbackground\x3d333
      SETUVAR fish_pager_color_selected_completion:\x1d
      SETUVAR fish_pager_color_selected_description:\x1d
      SETUVAR fish_pager_color_selected_prefix:\x1d

      # shell inits
      eval $(atuin init fish)
      eval $(direnv hook fish)
      eval $(starship init fish)
      eval $(chezmoi completion fish)
      eval $(just --completions fish)
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
