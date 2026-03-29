{ ... }:
let
  # Nord color palette — kept in sync with tmux.nix
  nordActiveBackground = "#181E2A";
  nordInactiveBackground = "#2E3440";
  nordElevatedBackground     = "#3B4252";
  nordSelection     = "#434C5E";
  nordMarker     = "#4C566A";
  nordSubtext     = "#D8DEE9";
  nordText     = "#E5E9F0";
  nordAccent     = "#8FBCBB";
  nordPrimary     = "#88C0D0";
  nordError    = "#BF616A";
  nordWarning    = "#EBCB8B";
  nordSuccess    = "#A3BE8C";

  # Powerline separator glyphs (Nerd Fonts Private Use Area, U+E0B0 / U+E0B2)
  pl  = "";  # solid right-pointing arrow — between left blocks
  plL = "";  # solid left-pointing arrow  — cap before right blocks
in
{
  programs.starship = {
    enable = true;
    # enableZshIntegration injects `eval "$(starship init zsh)"` into programs.zsh
    # automatically once programs.zsh is enabled (Section 1 shell migration).
    enableZshIntegration = true;

    settings = {
      # Disable all modules not explicitly included above
      aws.disabled           = true;
      azure.disabled         = true;
      buf.disabled           = true;
      c.disabled             = true;
      cmake.disabled         = true;
      cobol.disabled         = true;
      conda.disabled         = true;
      crystal.disabled       = true;
      daml.disabled          = true;
      dart.disabled          = true;
      deno.disabled          = true;
      docker_context.disabled = true;
      dotnet.disabled        = true;
      elixir.disabled        = true;
      elm.disabled           = true;
      erlang.disabled        = true;
      fennel.disabled        = true;
      fossil_branch.disabled = true;
      gcloud.disabled        = true;
      golang.disabled        = true;
      gradle.disabled        = true;
      guix_shell.disabled    = true;
      haskell.disabled       = true;
      haxe.disabled          = true;
      helm.disabled          = true;
      java.disabled          = true;
      julia.disabled         = true;
      kotlin.disabled        = true;
      kubernetes.disabled    = true;
      # lua enabled below
      memory_usage.disabled  = true;
      meson.disabled         = true;
      nim.disabled           = true;
      nix_shell.disabled     = true;
      ocaml.disabled         = true;
      opa.disabled           = true;
      openstack.disabled     = true;
      package.disabled       = true;
      perl.disabled          = true;
      php.disabled           = true;
      pulumi.disabled        = true;
      purescript.disabled    = true;
      raku.disabled          = true;
      red.disabled           = true;
      rlang.disabled         = true;
      ruby.disabled          = true;
      rust.disabled          = true;
      scala.disabled         = true;
      singularity.disabled   = true;
      solidity.disabled      = true;
      spack.disabled         = true;
      swift.disabled         = true;
      terraform.disabled     = true;
      typst.disabled         = true;
      vagrant.disabled       = true;
      vcsh.disabled          = true;
      vlang.disabled         = true;
      zig.disabled           = true;

      # ---------------------------------------------------------------------------
      # Two-line prompt matching alien layout:
      #   Line 1: [path|nordMarker] → [branch|nordSelection] → [git status|nordPrimary] → $fill → [duration] [time|nordPrimary]
      #   Line 2: [ssh?] [exit status?] [venv?] [node?] ❯
      # ---------------------------------------------------------------------------
      add_newline = false;

      format = "(fg:${nordMarker})$directory[${pl}](fg:${nordMarker} bg:${nordSelection})$git_branch[${pl}](fg:${nordSelection} bg:${nordElevatedBackground})$git_status[${pl}](fg:${nordElevatedBackground}) $hostname$status$python$nodejs$lua$fill[${plL}](fg:${nordPrimary})$cmd_duration$time\n$character";

      # ---------------------------------------------------------------------------
      # Line 1 — left blocks
      # ---------------------------------------------------------------------------
      directory = {
        style                    = "bg:${nordMarker} fg:${nordPrimary}";
        format                   = "[ $path ]($style)";
        truncate_to_repo         = false;
        fish_style_pwd_dir_length = 1;
      };

      git_branch = {
        style  = "bg:${nordSelection} fg:${nordPrimary}";
        format = "[ $symbol $branch ]($style)";
        symbol = "";
      };

      git_status = {
        style    = "bg:${nordElevatedBackground} fg:${nordPrimary}";
        format   = "[ ($stashed$ahead_behind$staged$modified$untracked$deleted$renamed)]($style)";
        ahead    = "[$count ](bg:${nordElevatedBackground} fg:${nordPrimary})";
        behind   = "[$count ](bg:${nordElevatedBackground} fg:${nordPrimary})";
        diverged = "[$ahead_count$behind_count ](bg:${nordElevatedBackground} fg:${nordPrimary})";
        stashed   = "[@$count ](bg:${nordElevatedBackground} fg:${nordPrimary})";
        staged    = "[●$count ](fg:${nordSuccess} bg:${nordElevatedBackground})";
        modified  = "[●$count ](fg:${nordWarning} bg:${nordElevatedBackground})";
        untracked = "[●$count ](fg:${nordError} bg:${nordElevatedBackground})";
        deleted   = "[✗$count ](fg:${nordError} bg:${nordElevatedBackground})";
        renamed   = "[»$count ](fg:${nordPrimary} bg:${nordElevatedBackground})";
      };

      fill.symbol = " ";

      # ---------------------------------------------------------------------------
      # Line 1 — right (after $fill)
      # ---------------------------------------------------------------------------

      # NEW: show duration for commands that took more than 2 seconds
      cmd_duration = {
        style    = "fg:${nordWarning}";
        format   = "[ ⏱$duration ]($style)";
        min_time = 2000;
      };

      time = {
        disabled    = false;
        style       = "bg:${nordPrimary} fg:${nordActiveBackground}";
        format      = "[ $time ]($style)";
        time_format = "%H:%M:%S";
      };

      # ---------------------------------------------------------------------------
      # Line 2
      # ---------------------------------------------------------------------------

      # Show user@host only when connected via SSH (matches alien's ssh section)
      hostname = {
        ssh_only = true;
        style    = "fg:${nordText}";
        format   = "[$hostname ]($style)";
        trim_at  = "";
      };

      # Show exit code when non-zero (alien's exit section)
      status = {
        disabled = false;
        style    = "fg:${nordSubtext}";
        format   = "[$status ]($style)";
      };

      # Show virtualenv name when active (matches alien's venv section)
      python = {
        style            = "fg:${nordPrimary}";
        format           = "[$symbol $virtualenv ]($style)";
        symbol           = "";
        detect_extensions = [];
        detect_files     = [];
        detect_folders   = [];
      };

      # Node version — matches alien's ALIEN_VERSIONS_PROMPT='NODE'
      nodejs = {
        style  = "fg:${nordPrimary}";
        format = "[$symbol $version ]($style)";
        symbol = "";
      };

      lua = {
        style  = "fg:${nordPrimary}";
        format = "[$symbol $version ]($style)";
        symbol = "󰢱";
      };

      # Prompt character — color reflects last exit status (replaces alien's exit + prompt sections)
      character = {
        success_symbol = "[❯](fg:${nordPrimary})";
        error_symbol   = "[❯](fg:${nordError})";
      };
    };
  };
}
