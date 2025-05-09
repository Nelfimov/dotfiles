{
  description = "Nelfimov nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util"; # Add indexing to Spotlight

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
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, mac-app-util, nix-homebrew, homebrew-core, homebrew-cask }:
  let
    configuration = { pkgs, ... }: {
      nixpkgs = {
        config = {
          allowBroken = true;
          allowUnfree = true;
        };
        hostPlatform = "aarch64-darwin";
      };

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
          pkgs.bitwarden
          pkgs.devpod
          pkgs.warp-terminal
          pkgs.gnupg
          pkgs.pinentry_mac
          pkgs.nodejs
          pkgs.cargo
        ];

      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
      ];

      homebrew = {
        enable = true;
        casks = [
          "figma"
          "libreoffice"
          "orbstack"
          "telegram"
        ];
        onActivation = {
          cleanup = "zap";
          autoUpdate = true;
          upgrade = true;
        };
      };

      system.defaults = {
        dock = {
          autohide = true;
          persistent-apps = [
            "/Applications/Safari.app"
            "/System/Applications/Messages.app"
            "/System/Applications/FaceTime.app"
            "/Applications/Telegram.app"
            "/System/Applications/Mail.app"
            "${pkgs.warp-terminal}/Applications/Warp.app"
            "/System/Applications/Calendar.app"
            "/System/Applications/Reminders.app"
            "/System/Applications/Notes.app"
            "/System/Applications/Music.app"
          ];
          persistent-others = [
            "/Users/nelfimov/Downloads"
          ];
          minimize-to-application = true;
          orientation = "bottom";
          show-process-indicators = true;
          show-recents = false;
          wvous-tr-corner = 12;
        };
        finder = {
          FXPreferredViewStyle = "clmv";
          NewWindowTarget = "Documents";
          ShowPathbar = true;
          AppleShowAllExtensions = true;
        };
        hitoolbox.AppleFnUsageType = "Change Input Source";
        loginwindow.GuestEnabled = false;
        NSGlobalDomain = {
          AppleICUForce24HourTime = true;
          AppleInterfaceStyle = "Dark";
          KeyRepeat = 2;
          AppleKeyboardUIMode = 3;
          ApplePressAndHoldEnabled = false;
          AppleShowScrollBars = "Automatic";
          InitialKeyRepeat = 1;
          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticDashSubstitutionEnabled = false;
          NSAutomaticInlinePredictionEnabled = false;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticSpellingCorrectionEnabled = false;
          "com.apple.mouse.tapBehavior" = 1;
        };
        SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
        screencapture.disable-shadow = false;
      };

      system = {
        keyboard = {
          remapCapsLockToControl = false;
          remapCapsLockToEscape = false;
        };
        configurationRevision = self.rev or self.dirtyRev or null;
        stateVersion = 6;
      };

      nix.settings.experimental-features = "nix-command flakes";

      security.pam.services.sudo_local.touchIdAuth = true;

      programs.zsh = {
        enable = true;
        enableSyntaxHighlighting = true;
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#mac
    darwinConfigurations."mac" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        mac-app-util.darwinModules.default
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "nelfimov";
            autoMigrate = true;
          };
        }
      ];
    };
  };
}
