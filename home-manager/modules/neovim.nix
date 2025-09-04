{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    types
    optionals
    optional
    flatten
    ;
  cfg = config.modules.nvimToolchains;
  inherit (pkgs.stdenv) isLinux;
in
{
  options.modules.nvimToolchains = {
    enable = mkEnableOption "Provide language toolchains and LSPs for Neovim/AstroNvim via one module";

    languages = {
      go = mkEnableOption "Go (go, gopls, delve, linters)" // {
        default = true;
      };
      rust = mkEnableOption "Rust (rustc, cargo, rust-analyzer, clippy, rustfmt)" // {
        default = true;
      };
      c_cpp = mkEnableOption "C/C++ (clang, clangd, build tools)" // {
        default = true;
      };
      php = mkEnableOption "PHP (php, composer, phpactor, formatters/linters)" // {
        default = true;
      };
      ruby = mkEnableOption "Ruby (ruby, ruby-lsp)" // {
        default = true;
      };
      python = mkEnableOption "Python (pyright, ruff, black, isort)" // {
        default = true;
      };
      lua = mkEnableOption "Lua (lua-language-server, stylua)" // {
        default = true;
      };
      nix = mkEnableOption "Nix (nixd, formatters/linters)" // {
        default = true;
      };
      web = mkEnableOption "Web basics (TS/JS, HTML/CSS/JSON, YAML, Bash, Dockerfile)" // {
        default = true;
      };
      misc =
        mkEnableOption "Helpful CLI utilities for Neovim plugins (ripgrep, fd, fzf, tree-sitter CLI)"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      withNodeJs = true;
      withPython3 = true;
      withRuby = true;

      extraPackages =
        with pkgs;
        flatten [
          (optional cfg.languages.misc ripgrep)
          (optional cfg.languages.misc fd)
          (optional cfg.languages.misc fzf)
          (optional cfg.languages.misc tree-sitter)

          (optionals cfg.languages.go [
            go
            gopls
            delve
            golangci-lint
          ])

          (optionals cfg.languages.rust [
            rust-analyzer
            rustc
            cargo
            clippy
            rustfmt
          ])

          (optionals cfg.languages.c_cpp (
            [
              clang
              clang-tools # includes clangd
              cmake
              gnumake
              pkg-config
              bear # helps generate compile_commands.json for clangd
            ]
            ++ (if isLinux then [ gcc ] else [ ])
          ))

          (optionals cfg.languages.php [
            php
            composer
            phpactor
            php-cs-fixer
            phpPackages.phpstan
          ])

          (optionals cfg.languages.ruby [
            ruby_3_3
            rubyPackages_3_3.ruby-lsp
          ])

          (optionals cfg.languages.python [
            python3
            pyright
            ruff-lsp
            black
            isort
          ])

          (optionals cfg.languages.lua [
            lua-language-server
            stylua
          ])

          (optionals cfg.languages.nix [
            nixd
            alejandra
            statix
            deadnix
          ])

          (optionals cfg.languages.web [
            nodejs
            typescript-language-server
            vscode-langservers-extracted # html/css/json
            yaml-language-server
            bash-language-server
            dockerfile-language-server-nodejs
          ])
        ];
    };
  };
}
