{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lazygit
    ripgrep
    stow
    fd
    fzf
    zoxide
    gh
    graphviz
    gnupg
    pinentry_mac
    nodejs
    cargo
    yarn
    tree
    rustup
    clickhouse-lts
  ];

  environment.interactiveShellInit = ''
    if [ -n "$REX_BIN_DIR" ]; then
      export PATH="$REX_BIN_DIR:$PATH"
    fi
  '';

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.martian-mono
  ];
}
