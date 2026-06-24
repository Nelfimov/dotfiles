{
  inputs,
  hostPlatform,
  user,
  ...
}:
{
  nix.enable = false;

  nixpkgs = {
    config.allowUnfree = true;
    inherit hostPlatform;
  };

  determinateNix = {
    enable = true;
    customSettings = {
      lazy-trees = true;

      keep-outputs = true;
      keep-derivations = true;

      accept-flake-config = true;
      extra-experimental-features = "nix-command flakes";
      trusted-users = [
        "root"
        user
      ];
      trusted-substituters = "https://cache.nixos.org/";
    };
    determinateNixd = {
      garbageCollector.strategy = "automatic";
      builder.state = "enabled";
    };
  };

  nix = {
    settings.experimental-features = "nix-command flakes";
    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
  };

  system = {
    keyboard = {
      remapCapsLockToControl = false;
      remapCapsLockToEscape = false;
    };
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    stateVersion = 6;
    primaryUser = user;
  };
}
