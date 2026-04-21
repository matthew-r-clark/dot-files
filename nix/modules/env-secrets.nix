{ lib, ... }:
{
  programs.zsh.initContent = lib.mkAfter ''
    # 1Password-backed env vars — resolved in a single `op inject` call (in-memory only).
    # If `op` is unavailable or the vault is locked, the eval is a no-op.
    if command -v op >/dev/null 2>&1; then
      eval "$(op inject --in-file "$HOME/dot-files/op/env-template" 2>/dev/null)"
    fi

  '';
}
