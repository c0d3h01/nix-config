{
  userConfig,
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    gitFull
    git-lfs
    git-crypt
    diffutils
    delta
    gh
    lazygit
    neovim
    bat
    eza
    fd
    ripgrep
    zoxide
    tmux
    fzf
    mise
    direnv
    nix-direnv
    sapling
    watchman
    gemini-cli
  ];

  programs.htop = {
    enable = true;
    settings =
      {
        tree_view = 1;
        hide_kernel_threads = 1;
        hide_userland_threads = 1;
        shadow_other_users = 1;
        show_thread_names = 1;
        show_program_path = 0;
        highlight_base_name = 1;
        header_layout = "two_67_33";
        color_scheme = 6;
      }
      // (with config.lib.htop; leftMeters [(bar "AllCPUs4")])
      // (
        with config.lib.htop;
          rightMeters [
            (bar "Memory")
            (bar "Swap")
            (bar "DiskIO")
            (bar "NetworkIO")
            (text "Systemd")
            (text "Tasks")
            (text "LoadAverage")
          ]
      );
  };
}
