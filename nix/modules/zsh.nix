{ config, ... }:
{
  home.sessionVariables = {
    DOTFILE_DIR   = "${config.home.homeDirectory}/dot-files";
    EDITOR        = "nvim";
    COLORTERM     = "truecolor";
    DELTA_PAGER   = "less -+X -+F --mouse";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.pyenv/shims"
    "${config.home.homeDirectory}/bin"
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.cargo/bin"
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

      # claude
      lzc = "lazyclaude";

      # docker
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
      eval "$(lazyclaude --print-shell-integration zsh)"

      npm() {
        if [[ "$1" == "login" ]]; then
          local dollar='$'
          local npm_key="//artifactory.internal.taillight.cloud/artifactory/api/npm/npm/:_authToken"
          local tlo_key="//artifactory.internal.taillight.cloud/artifactory/api/npm/tlo-npm/:_authToken"

          echo "Logging in to Artifactory npm registry..."
          command npm login --auth-type=legacy --registry=https://artifactory.internal.taillight.cloud/artifactory/api/npm/npm/ || return 1
          local npm_token
          npm_token=$(grep "^''${npm_key}=" ~/.npmrc | cut -d= -f2-)
          op item edit ARTIFACTORY_NPM_TOKEN credential="$npm_token" --vault=Employee
          command npm config set "$npm_key" "$dollar{ARTIFACTORY_NPM_TOKEN}"

          echo "Logging in to Artifactory tlo-npm registry..."
          command npm login --auth-type=legacy --registry=https://artifactory.internal.taillight.cloud/artifactory/api/npm/tlo-npm/ || return 1
          local tlo_token
          tlo_token=$(grep "^''${tlo_key}=" ~/.npmrc | cut -d= -f2-)
          op item edit ARTIFACTORY_TLO_NPM_TOKEN credential="$tlo_token" --vault=Employee
          command npm config set "$tlo_key" "$dollar{ARTIFACTORY_TLO_NPM_TOKEN}"
        else
          op run --env-file="$HOME/.config/npm/secrets.env" -- npm "$@"
        fi
      }

      npx() {
        op run --env-file="$HOME/.config/npm/secrets.env" -- npx "$@"
      }
    '';
  };
}
