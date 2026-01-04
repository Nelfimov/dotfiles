source ~/.shell_common.sh

if [[ "$TERM_PROGRAM" != *Warp* || -n "$ZELLIJ" ]]; then
  ## Git highlighting
  function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
  }
  function nix_shell_prompt() {
    [[ -n "$IN_NIX_SHELL" ]] && echo "%F{112}(nix)%f "
  }


  COLOR_DEF=$'%f'
  COLOR_USR=$'%F{243}'
  COLOR_DIR=$'%F{197}'
  COLOR_GIT=$'%F{39}'
  setopt PROMPT_SUBST
  NEWLINE=$'\n'
  export PROMPT="%{$fg[yellow]%}%D{%f/%m/%y} %D{%L:%M:%S} $(nix_shell_prompt)${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}\$(parse_git_branch)${COLOR_DEF}${NEWLINE}$ "
  # /Git highlighting

  source <(fzf --zsh)

  bindkey -v
  export keytimeout=1
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
compinit
# End of Docker CLI completions

# Auto-Warpify
printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh"}}\x9c'
