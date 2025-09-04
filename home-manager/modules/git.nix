# {
#   pkgs,
#   ...
# }:
# {
#   home.packages = with pkgs; [
#     git
#     git-lfs
#     delta
#     lazygit
#     mergiraf
#   ];
# }

{ lib, pkgs, ... }:

{
  programs.git = {
    enable = true;

    # --- Identity ---
    userName = "Harshal Sawant";
    userEmail = "harshalsawant.dev@gmail.com";
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };

    # --- Tools & Defaults ---
    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = false;
        line-numbers = true;
        syntax-theme = "TwoDark";
      };
    };

    aliases = {
      st = "status";
      br = "branch --all";
      lg = ''log --graph --decorate --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --abbrev-commit'';
      f = "fetch --all --prune";
      pf = "push --force-with-lease";
      pl = "pull";
      pr = "pull --rebase";
      dt = "difftool";
      amend = "commit -a --amend";
      wip = "!git add -u && git commit -m \"WIP\"";
      undo = "reset HEAD~1 --mixed";
      ignore = ''"!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi"'';
      trim = "!git remote prune origin && git gc";
    };

    # --- Extra Configuration ---
    extraConfig = {
      # Core
      core = {
        editor = "nvim";
        pager = "delta";
        autocrlf = false;
        safecrlf = true;
        excludesfile = "~/.gitignore";
        attributesfile = "~/.gitattributes";
        whitespace = "space-before-tab,-indent-with-non-tab,trailing-space";
        preloadindex = true;
      };
      init.defaultBranch = "main";

      # Color
      color = {
        ui = "auto";
      };

      # Diff & Merge
      diff = {
        tool = "nvim";
        algorithm = "patience";
        renames = "copies";
        mnemonicPrefix = true;
        compactionHeuristic = true;
      };
      "difftool.nvim".cmd = "nvim -d $LOCAL $REMOTE";
      merge = {
        tool = "nvim";
        conflictstyle = "zdiff3";
        log = true;
        keepBackup = false;
      };
      "mergetool.nvim".cmd = "nvim -d $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";

      # Push / Pull / Fetch
      push = {
        default = "simple";
        autoSetupRemote = true;
        recurseSubmodules = "on-demand";
        followTags = true;
      };
      pull = {
        rebase = true;
        autostash = true;
      };
      fetch = {
        prune = true;
        pruneTags = true;
        fsckobjects = true;
      };

      # Rebase
      rebase = {
        autosquash = true;
        autoStash = true;
        updateRefs = true;
        stat = true;
      };

      # Branch & Status
      branch = {
        autoSetupRebase = "always";
        autoSetupMerge = "always";
        sort = "-committerdate";
      };
      status = {
        showUntrackedFiles = "all";
        submoduleSummary = true;
      };

      # Logging
      log = {
        abbrevCommit = true;
        decorate = "short";
        date = "relative";
      };

      # Performance
      feature.manyFiles = true;
      index.threads = true;

      # Commit & Format
      commit = {
        verbose = true;
        template = "~/.gitmessage";
      };
      format = {
        signoff = false;
        pretty = "fuller";
      };

      # Misc
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      submodule = {
        fetchJobs = 4;
        recurse = true;
      };
      help.autocorrect = 10;
      tag.sort = "-version:refname";

      # GitHub
      github.user = "c0d3h01";
      credential = {
        helper = "cache";
        "https://github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
        "https://gist.github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };

      # GPG (SSH Signing)
      gpg.format = "ssh";
      "gpg.ssh" = {
        program = "/Applications/1Password 7.app/Contents/Resources/op-ssh-sign";
        allowedSignersFile = "~/.ssh/allowed_signers";
      };

      # LFS
      "filter.lfs" = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };

      # Security
      transfer.fsckobjects = true;
      receive.fsckObjects = true;

      # HTTP
      http = {
        cookiefile = "~/.gitcookies";
        lowSpeedLimit = 0;
        lowSpeedTime = 999999;
        postBuffer = 524288000;
      };

      # Advice
      advice = {
        statusHints = false;
        detachedHead = false;
        skippedCherryPicks = false;
        pushUpdateRejected = false;
        resolveConflict = false;
      };

      # Maintenance
      maintenance.repo = "/home/c0d3h01/dotfiles";

      # URL Shortcuts
      url = {
        "git@github.com:".insteadOf = "gh:";
        "git@github.com:".pushInsteadOf = [
          "github:"
          "git://github.com/"
        ];
        "git://github.com/".insteadOf = "github:";
        "git@gist.github.com:".insteadOf = "gst:";
        "git@gist.github.com:".pushInsteadOf = [
          "gist:"
          "git://gist.github.com/"
        ];
        "git://gist.github.com/".insteadOf = "gist:";
      };
    };
  };
}
