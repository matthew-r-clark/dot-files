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

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }: {
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
          home-manager.users."matthew.clark" = {
            imports = [ ./nix/home-shared.nix ./nix/home-darwin.nix ];
          };
        }
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
