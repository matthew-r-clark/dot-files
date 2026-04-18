{ config, ... }:
{
  home.sessionVariables = {
    DOTFILE_DIR   = "${config.home.homeDirectory}/dot-files";
    EDITOR        = "nvim";
    COLORTERM     = "truecolor";
    DELTA_PAGER   = "less -+X -+F --mouse";
    ODY_ENV       = "true";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.pyenv/shims"
    "${config.home.homeDirectory}/bin"
    "${config.home.homeDirectory}/.mvn/apache-maven-3.8.6/bin"
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/dot-files/cli-tools"
  ];

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable  = true;
      plugins = [ "git" ];
    };

    shellAliases = {
      # general
      c   = "clear";
      rg  = "rg --hidden -g '!.git'";

      # docker
      docker-compose = "docker compose";
      dc    = "docker compose";
      dcu   = "dc up -d";
      dcd   = "dc down";
      dcr   = "dc restart";
      dcl   = "dc logs -f";
      dcps  = "clear; dc ps;";
      lzd   = "lazydocker";

      # neovim
      n        = ''nvim +"silent! :source Session.vim"'';
      vw       = "nvim ~/vimwiki/index.wiki";
      nvimlogs = "tail -n 1000 -f logger.txt";

      # scripts
      gendockerfile = "~/development/taillight/od-env/build-node-docker/gendockerfile.sh";
      renderconsul  = "~/development/taillight/od-env/build-node-docker/render-consul-template.sh";

      # git
      lzg  = "lazygit";

      # oh-my-zsh extension: gsts (git stash show --patch) with untracked files
      gstv = "gsts -u";

      # stripe
      stripe-login = "op plugin init stripe";

      # ampy (MicroPython serial tool)
      py  = "ampy --port /dev/tty.usbmodem401101";
      pyg = "py get";
      pyp = "py put";
      pyr = "py run";
      pyd = "py rm";
      pyl = "py ls";
      pyu = "~/development/raspi/pyboard/download-file.sh";
    };

    initContent = ''
      # version managers
      eval "$(nodenv init -)"
      eval "$(rbenv init - zsh)"
    '';
  };
}
