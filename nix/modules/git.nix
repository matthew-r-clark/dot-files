{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Matthew Clark";
    userEmail = "matthew.clark@taillight.com";

    ignores = [
      ".nvimlog"
      "**/Session.vim"
      "logger.txt"
      ".vimwiki_last_backup_time"
      ".DS_Store"
      "cspell.json"
    ];

    delta = {
      enable = true; # wires up core.pager, interactive.diffFilter, diff.colorMoved
      options = {
        features = "custom-theme";
        navigate = true;
        line-numbers = true;
        side-by-side = true;
        pager = "less -R";

        # [delta "custom-theme"] — Nord palette
        "custom-theme" = {
          commit-style = "raw";
          commit-decoration-style = "bold box ul";
          dark = true;
          file-decoration-style = "\"#EBCB8B\" ul ol";
          file-modified-label = "modified:";
          file-style = "\"#EBCB8B\"";
          hunk-header-decoration-style = "\"#88C0D0\" box";
          hunk-header-style = "line-number syntax";
          line-numbers-left-style = "\"#022b45\"";
          line-numbers-minus-style = "\"#80002a\"";
          line-numbers-plus-style = "\"#345915\"";
          line-numbers-right-style = "\"#022b45\"";
          line-numbers-zero-style = "\"#999999\"";
          minus-emph-style = "bold \"#80002a\" \"#BF616A\"";
          minus-style = "bold \"#D8DEE9\" \"#80002a\"";
          plus-emph-style = "bold \"#2b5c02\" \"#A3BE8C\"";
          plus-style = "bold \"#D8DEE9\" \"#2b5c02\"";
          syntax-theme = "Nord";
          map-styles = "bold purple => bold blue, bold cyan => syntax blue";
          line-numbers-left-format = "┊{nm:>4}│";
          line-numbers-right-format = "┊{np:>4}│";
        };
      };
    };

    extraConfig = {
      push.autoSetupRemote = true;
      pull.rebase = true;
      core.ignoreCase = true;
      rerere.enabled = true;
      merge.conflictstyle = "diff3";
      pager = {
        diff = "delta";
        log = "delta";
        show = "delta";
      };
    };
  };
}
