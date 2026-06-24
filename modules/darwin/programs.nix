{
  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.watchIdAuth = true;

  programs = {
    zsh = {
      enable = true;
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;
      enableCompletion = true;
    };

    direnv.enable = true;
  };
}
