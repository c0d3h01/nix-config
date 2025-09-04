{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (pkgs.stdenv) isDarwin;
  inherit (pkgs.stdenv) isLinux;

  ghCredHelper = "!${pkgs.gh}/bin/gh auth git-credential";

  sshSignerProgram =
    if isDarwin then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" else "op-ssh-sign";
in
{
  home.file.".gitignore".source = ./gitignore;
  home.file.".gitattributes".source = ./gitattributes;

  programs.git = {
    enable = true;

    package = pkgs.gitFull;

    userName = "Harshal Sawant";
    userEmail = "harshalsawant.dev@gmail.com";

    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };

    lfs.enable = true;

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
      lg = ''log --graph --decorate --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --abbrev-commit'';
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

    extraConfig = {
      init.defaultBranch = "main";

      core = {
        editor = "nvim";
        autocrlf = false;
        safecrlf = true;
        excludesfile = "~/.gitignore";
        attributesfile = "~/.gitattributes";
        whitespace = "space-before-tab,-indent-with-non-tab,trailing-space";
        preloadindex = true;
      };

      color.ui = "auto";

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
      };
      mergetool.keepBackup = false;
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
        autostash = true;
        updateRefs = true;
        stat = true;
      };

      # Branch & Status
      branch = {
        autoSetupRebase = "always";
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
      index.threads = 0; # auto-select threads

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

      # Auth (platform-aware default helper + gh for GitHub domains)
      credential.helper = if isDarwin then "osxkeychain" else "libsecret";
      "https://github.com".credential.helper = ghCredHelper;
      "https://gist.github.com".credential.helper = ghCredHelper;

      # SSH signing
      gpg.format = "ssh";
      "gpg.ssh".program = sshSignerProgram;
      "gpg.ssh".allowedSignersFile = "~/.ssh/allowed_signers";

      # Security
      transfer.fsckobjects = true;
      receive.fsckObjects = true;

      # HTTP (avoid deprecated postBuffer)
      http = {
        cookiefile = "~/.gitcookies";
        lowSpeedLimit = 0;
        lowSpeedTime = 999999;
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
