{
  description = "Nelfimov nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util"; # Add indexing to Spotlight

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";

    # Homebrew
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    buildpack = {
      url = "github:buildpacks/homebrew-tap";
      flake = false;
    };
    macism = {
      url = "github:laishulu/homebrew-homebrew";
      flake = false;
    };
    aerospace = {
      url = "github:nikitabobko/homebrew-tap";
      flake = false;
    };
  };

  outputs =
    inputs@{
      nix-darwin,
      determinate,
      mac-app-util,
      nix-homebrew,
      ...
    }:
    let
      user = "nelfimov";
      hostPlatform = "aarch64-darwin";
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#mac
      darwinConfigurations."mac" = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs user hostPlatform;
        };

        modules = [
          ./hosts/mac.nix
          determinate.darwinModules.default
          mac-app-util.darwinModules.default
          nix-homebrew.darwinModules.nix-homebrew
          ./modules/darwin/nix-homebrew.nix
        ];
      };
    };
}
