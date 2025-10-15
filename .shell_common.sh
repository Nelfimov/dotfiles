#!/usr/bin/env sh

export HISTSIZE=5000
export HISTFILESIZE="$HISTSIZE"

if [ -n "$BASH_VERSION" ]; then
  export HISTCONTROL="ignoredups:erasedups"
fi

export GPG_TTY="$(tty)"

export K9S_CONFIG_DIR="$HOME/.config/k9s/"
export KUBE_EDITOR=nvim

# Jetbrains hack
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"
if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
# /Jetbrains hack

ulimit -n 4096

# Aliases
alias ls='ls --color'
alias g='git'

alias obsidian='cd ~/Documents/Dev/Obsidian/work && nvim'
alias dotfiles='cd ~/Documents/Dev/dotfiles && nvim'

alias tf='terraform'
alias tfi='terraform init && terraform providers lock -platform=linux_amd64'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tff='terraform fmt'

alias dc='docker compose'
alias dcc='docker compose create'
alias dcd='docker compose down'
alias dcu='docker compose up'

alias k='kubectl'
alias kx='kubectl exec -it'
alias kg='kubectl get'
alias kge='kubectl get events --sort-by=".lastTimestamp"'
alias kl='kubectl logs'

alias ghpc='gh pr create -a @me --fill-first'
alias ghpm='gh pr merge -s --admin -d'

dev() {
  session_name="$(basename "$PWD")"
  nix develop -c zellij --session "$session_name"
}
