if [[ "$TERM_PROGRAM" != *Warp* ]]; then
  source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
  zstyle -e ':autocomplete:*:*' list-lines 'reply=( $(( LINES / 2 )) )'
  bindkey -M menuselect  '^[[D' .backward-char  '^[OD' .backward-char
  bindkey -M menuselect  '^[[C'  .forward-char  '^[OC'  .forward-char

  source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  
  ## Git highlighting
  function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
  }

  COLOR_DEF=$'%f'
  COLOR_USR=$'%F{243}'
  COLOR_DIR=$'%F{197}'
  COLOR_GIT=$'%F{39}'
  setopt PROMPT_SUBST
  export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} $ '
  # /Git highlighting

  source <(fzf --zsh)
fi

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

eval "$(zoxide init zsh --cmd cd)"

plugins=(git)

## SSH Config File Completion
zstyle ':completion:*:*:ssh:*' hosts $(awk '/^Host / {print $2}' ~/.ssh/config ~/.ssh/known_hosts ~/.ssh/orgs/* 2>/dev/null | tr ' ' '\n' | sort -u)

# /SSH

## GPG
export GPG_TTY=$(tty)
# /GPG

export K9S_CONFIG_DIR=~/.config/k9s/

# Jetbrains hack
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
# /Jetbrains hack

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
  [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
  [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
# /Node Version Manager

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
# /Aliases

