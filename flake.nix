{
  description = "Nelfimov nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, mac-app-util }:
  let
    configuration = { pkgs, ... }: {
      # nixpkgs.config.allowBroken = true;
      nixpkgs.config.allowUnfree = true;
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          pkgs.neovim
          pkgs.zellij
          pkgs.aerospace
          pkgs.lazygit
          pkgs.ripgrep
          pkgs.stow
          pkgs.fd
          pkgs.fzf
          pkgs.zoxide
          pkgs.ripgrep
          pkgs.k9s
          pkgs.gh
          pkgs.graphviz
          pkgs.zsh-syntax-highlighting
          pkgs.zsh-autosuggestions
          pkgs.zsh-autocomplete
          pkgs.buildpack
          pkgs.transmission
          pkgs.bitwarden
          pkgs.devpod
        ];

      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
      ];
      system.defaults = {
        dock.autohide = true;
        dock.persistent-apps = [
          "/Applications/Safari.app"
          "/System/Applications/Messages.app"
          "/System/Applications/FaceTime.app"
          "/Applications/Telegram.app"
          "/System/Applications/Mail.app"
          "/Applications/Warp.app"
          "/System/Applications/Calendar.app"
          "/System/Applications/Reminders.app"
          "/System/Applications/Notes.app"
          "/System/Applications/Music.app"
        ];
        dock.persistent-others = [
          "/Users/nelfimov/Downloads"
        ];
        finder.FXPreferredViewStyle = "clmv";
        finder.NewWindowTarget = "Documents";
        finder.ShowPathbar = true;
        hitoolbox.AppleFnUsageType = "Change Input Source";
        loginwindow.GuestEnabled = false;
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.KeyRepeat = 2;
        NSGlobalDomain.AppleKeyboardUIMode = 3;
        NSGlobalDomain.ApplePressAndHoldEnabled = false;
        NSGlobalDomain.AppleShowScrollBars = "Automatic";
        NSGlobalDomain.InitialKeyRepeat = 1;
        NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
        NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
        NSGlobalDomain.NSAutomaticInlinePredictionEnabled = false;
        NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
        NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
        NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
        SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
        dock.minimize-to-application = true;
        dock.orientation = "bottom";
        dock.show-process-indicators = true;
        dock.show-recents = false;
        dock.wvous-tr-corner = 12;
        screencapture.disable-shadow = false;
      };

      system = {
        keyboard.remapCapsLockToControl = false;
        keyboard.remapCapsLockToEscape = false;
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#mac
    darwinConfigurations."mac" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        mac-app-util.darwinModules.default
      ];
    };
  };
}
