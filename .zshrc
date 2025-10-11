source ~/.shell_common.sh

if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
  source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
fi

if [[ "$TERM_PROGRAM" != *Warp* || -n "$ZELLIJ" ]]; then
  ## Git highlighting
  function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
  }

  COLOR_DEF=$'%f'
  COLOR_USR=$'%F{243}'
  COLOR_DIR=$'%F{197}'
  COLOR_GIT=$'%F{39}'
  setopt PROMPT_SUBST
  NEWLINE=$'\n'
  export PROMPT="%{$fg[yellow]%}%D{%f/%m/%y} %D{%L:%M:%S} ${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}\$(parse_git_branch)${COLOR_DEF}${NEWLINE}$ "
  # /Git highlighting

  source <(fzf --zsh)

  set -o vi
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

eval "$(zoxide init zsh --cmd cd)"

plugins=(git)

zstyle ':completion:*:*:ssh:*' hosts $(awk '/^Host / {print $2}' ~/.ssh/config ~/.ssh/known_hosts 2>/dev/null | tr ' ' '\n' | sort -u)

# Auto-Warpify
[[ "$-" == *i* ]] && printf 'P$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh", "uname": "Darwin" }}�' 
