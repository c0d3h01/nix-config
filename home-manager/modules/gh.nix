{
  lib,
  pkgs,
  config,
  ...
}:
{
  programs.gh = {
    enable = true;

    extensions = with pkgs; [
      gh-cal
      gh-copilot
      gh-eco
    ];

    settings = {
      version = "1";
      git_protocol = "ssh";
      editor = "nvim";
      http_unix_socket = "";

      # keep prompts interactive
      prompt = "enabled";
      prefer_editor_prompt = "enabled";

      # no pager clutter
      pager = "bat";

      aliases = {
        co = "pr checkout";
        pv = "pr view --web";
        rv = "repo view --web";
        myi = "issue list --assignee=@me";
        myp = "pr list --assignee=@me";
      };

      # let gh open URLs in your dev browser
      browser = "firefox";

      # better visibility in terminals
      color_labels = "enabled";
      accessible_colors = "enabled";
      accessible_prompter = "enabled";

      # spinner feedback is fine for interactive runs
      spinner = "enabled";
    };
  };
}
