{ ... }:
{
  system.defaults = {

    # -------------------------------------------------------------------------
    # Dock
    # -------------------------------------------------------------------------
    dock = {
      autohide    = true;
      tilesize    = 44;
      # Don't rearrange Spaces based on most recent use
      mru-spaces  = false;
    };

    # -------------------------------------------------------------------------
    # Finder
    # -------------------------------------------------------------------------
    finder = {
      # Gallery view
      FXPreferredViewStyle = "glyv";
      ShowStatusBar        = false;
    };

    # -------------------------------------------------------------------------
    # Global / keyboard
    # -------------------------------------------------------------------------
    NSGlobalDomain = {
      # Dark mode
      AppleInterfaceStyle = "Dark";

      # Fast key repeat (lower = faster; macOS default is 6/2)
      InitialKeyRepeat = 15;
      KeyRepeat        = 2;

      # Disable natural (reverse) scrolling
      "com.apple.swipescrolldirection" = false;
    };
  };
}
