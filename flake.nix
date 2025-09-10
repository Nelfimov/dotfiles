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
      nix.enable = false;
      nixpkgs = {
        config = {
          allowUnfree = true;
        };
        hostPlatform = "aarch64-darwin";
      };

      environment.systemPackages = with pkgs;
        [
          neovim
          zellij
          aerospace
          lazygit
          ripgrep
          stow
          fd
          fzf
          zoxide
          k9s
          gh
          graphviz
          zsh-syntax-highlighting
          zsh-autosuggestions
          gnupg
          pinentry_mac
          nodejs_24
          cargo
          pack
          yarn
          tree
        ];

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      homebrew = {
        enable = true;
        brews = [
          "mas"
        ];
        casks = [
          "figma"
          "libreoffice"
          "orbstack"
          "telegram"
          "ghostty"
          "discord"
          "amneziavpn"
          "transmission"
          "chromium-gost"
          "chatgpt"
          "warp"
          "gitify"
          "vlc"
        ];
        onActivation = {
          cleanup = "zap";
          autoUpdate = true;
          upgrade = true;
        };
        masApps = {
          Bitwarden = 1352778147;
          AdGuard = 1440147259;
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
            "/Applications/Ghostty.app"
            "/Applications/Warp.app"
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
          InitialKeyRepeat = 15;
          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticDashSubstitutionEnabled = false;
          NSAutomaticInlinePredictionEnabled = false;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticSpellingCorrectionEnabled = false;
          "com.apple.mouse.tapBehavior" = 1;
        };
        SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
        screencapture.disable-shadow = false;
        CustomSystemPreferences = {
          NSGlobalDomain = {
            # Add a context menu item for showing the Web Inspector in web views
            WebKitDeveloperExtras = true;
          };
          # Prevent Photos from opening automatically when devices are plugged in
          "com.apple.ImageCapture".disableHotPlug = true;
          "com.apple.AdLib" = {
            allowApplePersonalizedAdvertising = false;
          };
          "com.apple.Safari" = {
            # Press Tab to highlight each item on a web page
            WebKitTabToLinksPreferenceKey = true;
            ShowFullURLInSmartSearchField = false;
            IncludeInternalDebugMenu = true;
            IncludeDevelopMenu = true;
            WebKitDeveloperExtrasEnabledPreferenceKey = true;
            WebContinuousSpellCheckingEnabled = true;
            WebAutomaticSpellingCorrectionEnabled = false;
            AutoFillFromAddressBook = false;
            AutoFillCreditCardData = false;
            AutoFillMiscellaneousForms = false;
            WarnAboutFraudulentWebsites = true;
            WebKitJavaEnabled = false;
            WebKitJavaScriptCanOpenWindowsAutomatically = false;
            "com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks" = true;
            "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
            "com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled" = false;
            "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled" = false;
            "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles" = false;
            "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically" = false;
            "com.apple.Safari.IncludeInternalDebugMenu" = true;
          };
        };
      };

      system = {
        keyboard = {
          remapCapsLockToControl = false;
          remapCapsLockToEscape = false;
        };
        configurationRevision = self.rev or self.dirtyRev or null;
        stateVersion = 6;
        primaryUser = "nelfimov";
      };

      nix = {
        settings.experimental-features = "nix-command flakes";
        extraOptions = ''
          extra-platforms = x86_64-darwin aarch64-darwin
        '';
      };

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
