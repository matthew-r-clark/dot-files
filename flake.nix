{
  description = "Matthew Clark's dotfiles — nix-darwin (macOS) + home-manager (Linux)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
  let
    pkgs = nixpkgs.legacyPackages.aarch64-darwin;
  in {
    # macOS: nix-darwin + home-manager
    # First activation: nix run nix-darwin -- switch --flake ~/dot-files
    # Subsequent:       darwin-rebuild switch --flake ~/dot-files
    darwinConfigurations."YGGXKP4X7W" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./nix/darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";
          home-manager.users."matthew.clark" = {
            imports = [ ./nix/home-shared.nix ./nix/home-darwin.nix ];
          };
        }
      ];
    };

    # `nix fmt` — format all .nix files
    formatter.aarch64-darwin = pkgs.alejandra;

    # `nix develop` — shell for working on the dotfiles themselves
    devShells.aarch64-darwin.default = pkgs.mkShell {
      packages = [
        pkgs.alejandra  # nix formatter
        pkgs.statix     # nix linter (anti-pattern detection)
        pkgs.deadnix    # find unused nix code
      ];
    };

    # Linux: standalone home-manager
    # First activation: nix run home-manager -- switch --flake ~/dot-files
    # Subsequent:       home-manager switch --flake ~/dot-files
    homeConfigurations."matthew.clark" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      modules = [
        ./nix/home-shared.nix
        ./nix/home-linux.nix
      ];
    };
  };
}
