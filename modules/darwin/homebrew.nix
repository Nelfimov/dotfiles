{
  homebrew = {
    enable = true;
    brews = [
      "pack"
      "macism"
      "mas"
      "statix"
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
      "mtr"
    ];
    casks = [
      "docker-desktop"
      "figma"
      "libreoffice"
      "telegram"
      "telegram-desktop" # TODO: rm once `telegram` is updated for MTProto
      "amneziavpn"
      "transmission"
      "chromium-gost"
      "vlc"
      "zoho-cliq"
      "adguard-vpn"
      "vial"
      "zoom"
      "aerospace"
      "codex"
      "steam"
      "kitty"
      "chatgpt"
      "obsidian"
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
