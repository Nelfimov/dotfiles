{
  config,
  inputs,
  user,
  ...
}:
{
  homebrew.taps = builtins.attrNames config.nix-homebrew.taps;

  nix-homebrew = {
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "FelixKratz/homebrew-formulae" = inputs.janky-borders;
      "buildpacks/homebrew-tap" = inputs.buildpack;
      "laishulu/homebrew-homebrew" = inputs.macism;
      "nikitabobko/homebrew-tap" = inputs.aerospace;
    };
    enable = true;
    enableRosetta = true;
    inherit user;
    autoMigrate = true;
    mutableTaps = false;
    trust = {
      taps = [
        "buildpacks/tap"
        "laishulu/homebrew"
        "nikitabobko/tap"
      ];
    };
  };
}
