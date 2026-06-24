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
    clickhouse
    # pi-coding-agent #FIXME: restore when fixed build
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.martian-mono
  ];
}
