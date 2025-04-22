source ~/.shell_common.sh

if [ -f /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
fi

source /usr/share/bash-autocomplete/bash-autocomplete.sh

source <(fzf --bash)

eval "$(zoxide init bash --cmd cd)"
