source ~/.shell_common.sh

if [[ "$TERM_PROGRAM" != *Warp* || -n "$ZELLIJ" ]]; then
  AUTOSUGGEST=$(nix eval --raw nixpkgs#zsh-autosuggestions.outPath)
  source $AUTOSUGGEST/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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
  export PROMPT="${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}\$(parse_git_branch)${COLOR_DEF}${NEWLINE}$ "
  RPROMPT="%{$fg[yellow]%}%D{%f/%m/%y} %D{%L:%M:%S}"
  # /Git highlighting

  source <(fzf --zsh)
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
