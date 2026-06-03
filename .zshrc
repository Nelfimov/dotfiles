[ -f "$HOME/.shell_common.sh" ] && source "$HOME/.shell_common.sh"

if [[ $- == *i* && "$TERM_PROGRAM" != *Warp* ]]; then
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
    command -v kubectl >/dev/null 2>&1 || return
    kubectl config current-context 2>/dev/null || return
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

  if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
  fi

  bindkey -v
  export KEYTIMEOUT=1
fi

if [[ $- == *i* ]]; then
  HISTDUP=erase
  setopt appendhistory
  setopt sharehistory
  setopt hist_ignore_all_dups
  setopt hist_save_no_dups
  setopt hist_ignore_dups
  setopt hist_find_no_dups

  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
  if [[ -n "${LS_COLORS:-}" ]]; then
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
  fi
  zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

  if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh --cmd z)"
  fi

  zstyle ':completion:*:*:ssh:*' hosts $(awk '/^Host / {print $2}' ~/.ssh/config ~/.ssh/known_hosts 2>/dev/null | tr ' ' '\n' | sort -u)

  # The following lines have been added by Docker Desktop to enable Docker CLI completions.
  if [ -d /Users/nelfimov/.docker/completions ]; then
    fpath=(/Users/nelfimov/.docker/completions $fpath)
  fi
  autoload -Uz compinit
  compinit -C
  # End of Docker CLI completions
fi

# PostgreSQL exec
if [ -d /opt/homebrew/opt/libpq/bin ] && [[ ":$PATH:" != *":/opt/homebrew/opt/libpq/bin:"* ]]; then
  export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
fi
