source ~/.shell_common.sh

if [[ "$TERM_PROGRAM" != *Warp* ]]; then
  ## Git highlighting
  function parse_git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
    echo "[$branch]"
  }
  function direnv_shell_prompt() {
    [[ -n "${DIRENV_FILE:-}" ]] && echo "%F{112}(direnv)%f "
  }
  function kubectl_shell_prompt() {
    kubectl config current-context || return
  }

  COLOR_DEF=$'%f'
  COLOR_USR=$'%F{243}'
  COLOR_DIR=$'%F{197}'
  COLOR_GIT=$'%F{39}'
  COLOR_KUBE=$'%F{cyan}'
  setopt PROMPT_SUBST
  # /Git highlighting
  NEWLINE=$'\n'
  export PROMPT="%{$fg[yellow]%}%D{%f/%m} %D{%H:%M:%S} \$(direnv_shell_prompt)${COLOR_DIR}%~ ${COLOR_GIT}\$(parse_git_branch) ${COLOR_KUBE}\$(kubectl_shell_prompt)${COLOR_DEF}${NEWLINE}$ "

  source <(fzf --zsh)

  bindkey -v
  export KEYTIMEOUT=1
fi

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

eval "$(zoxide init zsh --cmd z)"

plugins=(git)

zstyle ':completion:*:*:ssh:*' hosts $(awk '/^Host / {print $2}' ~/.ssh/config ~/.ssh/known_hosts 2>/dev/null | tr ' ' '\n' | sort -u)

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/nelfimov/.docker/completions $fpath)
autoload -Uz compinit
compinit -C
# End of Docker CLI completions

# PostgreSQL exec
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
