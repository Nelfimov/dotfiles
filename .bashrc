source ~/.shell_common.sh

if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
  builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
fi

if [ -f /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
fi

if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

eval "$(fzf --bash)"

eval "$(zoxide init bash --cmd cd)"
. "$HOME/.cargo/env"
