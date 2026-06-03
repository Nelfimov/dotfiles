if [ -f "$HOME/.shell_common.sh" ]; then
  source "$HOME/.shell_common.sh"
fi

if [[ $- == *i* ]]; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi

  if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --bash)"
  fi

  if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash --cmd cd)"
  fi

  set -o vi

  # Make vi-mode state visible: block cursor in command mode, bar cursor in insert mode.
  if [ -t 0 ]; then
    bind 'set show-mode-in-prompt on'
    bind 'set vi-cmd-mode-string "\1\e[2 q\2"'
    bind 'set vi-ins-mode-string "\1\e[6 q\2"'
  fi

  # Aliases
  if ls --color >/dev/null 2>&1; then
    alias ls='ls --color --hyperlink=auto'
  fi
fi
