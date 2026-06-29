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

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.martian-mono
  ];
}
