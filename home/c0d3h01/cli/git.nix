{
  lib,
  pkgs,
  self,
  config,
  ...
}:
let
  inherit (lib) mkIf mkMerge map;
  inherit (self.lib) giturl;
  inherit (lib.hm.dag) entryBefore;

  cfg = config.programs.git;
in
{
  config = mkIf cfg.enable (mkMerge [
    (mkIf config.garden.profiles.workstation.enable {
      garden.packages = {
        inherit (pkgs)
          gist # manage github gists
          # act # local github actions - littrally does not work
          gitflow # Extend git with the Gitflow branching model
          # git-lfs
          mergiraf
          lazygit
          ;
      };
    })

    # `programs.git` will generate the config file: ~/.config/git/config
    # to make git use this config file, `~/.gitconfig` should not exist!
    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      home.activation = {
        removeExistingGitconfig = entryBefore [ "checkLinkTargets" ] ''
          rm -f ~/.gitconfig
        '';
      };
    })

    {
      programs.git = {
        package = pkgs.gitMinimal;
        userName = "c0d3h01";
        userEmail = "harshalsawant.dev" + "@" + "gmail" + "." + "com";

        ignores = [
          # system residue
          ".cache/"
          ".DS_Store"
          ".Trashes"
          ".Trash-*"
          "*.bak"
          "*.swp"
          "*.swo"
          "*.elc"
          ".~lock*"

          # build residue
          "tmp/"
          "target/"
          "result"
          "result-*"
          "*.exe"
          "*.exe~"
          "*.dll"
          "*.so"
          "*.dylib"

          # ide residue
          ".idea/"
          ".vscode/"

          # dependencies
          ".direnv/"
          "node_modules"
          "vendor"
        ];

        extraConfig = {
          help.autocorrect = 10;
          lfs.enable = true;
          commit.verbose = true;

          mergetool = {
            prompt = false;
            path = "nvim-open";
          };

          # signing = {
          #   format = "ssh";
          #   signByDefault = true;
          # };

          delta = {
            enable = true;
            options = {
              navigate = true;
              side-by-side = true;
              line-numbers = true;
            };
          };

          "filter \"lfs\"" = {
            clean = "git-lfs clean -- %f";
            smudge = "git-lfs smudge -- %f";
            process = "git-lfs filter-process";
            required = true;
          };

          aliases = {
            clone = "clone --recursive";
            blame = "-w -M";
            update = "!git pull && git submodule update --init --recursive";
            comma = "commit --amend";
            uncommit = "reset --soft HEAD^";
            backport = "cherry-pick -x";
            checkout-pr = "!'pr() { git fetch origin pull/$1/head:pr-$1; git checkout pr-$1; }; pr'";
            pick-pr = "!'am() { git fetch origin pull/$1/head:pr-$1; git cherry-pick HEAD..pr-$1; }; am'";
            reset-pr = "reset --hard FETCH_HEAD";
            force-push = "push --force-with-lease";
            publish = "!git pull && git push";
            # recover failed commit messages: https://stackoverflow.com/questions/9133526/git-recover-failed-commits-message
            recommit = "!git commit -eF $(git rev-parse --git-dir)/COMMIT_EDITMSG";
          };

          core.editor = config.garden.programs.defaults.editor;

          # Qol
          color.ui = "auto";

          diff = {
            algorithm = "histogram"; # a much better diff
            colorMoved = "plain"; # show moved lines in a different color
          };

          safe.directory = "*";
          # add some must-use flags
          pull.rebase = true;
          rebase = {
            autoSquash = true;
            autoStash = true;
          };
          merge.ff = "only";
          push.autoSetupRemote = true;

          # user.signingkey = config.sops.secrets.keys-gh.path;
          # personal preference
          init.defaultBranch = "main";
          # prevent data corruption
          transfer.fsckObjects = true;
          fetch.fsckObjects = true;
          receive.fsckObjects = true;

          magithub = {
            online = false;
            status = {
              includeStatusHeader = false;
              includePullRequestsSection = false;
              includeIssuesSection = false;
            };
          };

          http = {
            "github.com".SSLCypherList = "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH";
            cookiefile = "~/.gitcookies";
          };

          url = mkMerge (
            map giturl [
              {
                domain = "github.com";
                alias = "github";
              }
              {
                domain = "gitlab.com";
                alias = "gitlab";
              }
              {
                domain = "aur.archlinux.org";
                alias = "aur";
                user = "aur";
              }
              {
                domain = "codeberg.org";
                alias = "codeberg";
              }
            ]
          );
        };
      };
    }
  ]);
}
