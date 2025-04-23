source ~/.shell_common.sh

if [ -f /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
fi

if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

source <(fzf --bash)

eval "$(zoxide init bash --cmd cd)"
