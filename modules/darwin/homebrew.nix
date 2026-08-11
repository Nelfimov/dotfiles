{
  homebrew = {
    enable = true;
    brews = [
      "pack"
      "macism"
      "mas"
      "k9s"
      "neovim"
      "go"
      "tree-sitter-cli" # neovim LSP
      "nixfmt" # nix
      "watch"
      "imagemagick"
      "ffmpeg"
      "mole"
      "libpq" # postgres
      "ruby"
      "glab"
    ];
    casks = [
      "docker-desktop"
      "figma"
      "libreoffice"
      "telegram"
      "amneziavpn"
      "transmission"
      "chromium-gost"
      "vlc"
      "zoho-cliq"
      "adguard-vpn"
      "vial"
      "aerospace"
      "codex"
      "steam"
      "kitty"
      "chatgpt"
      "obsidian"
      "rubymine"
      "yandextelemost"
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    masApps = {
      Bitwarden = 1352778147;
      Ublock-origin-lite = 6745342698;
      VimLike = 1584519802;
    };
  };
}
