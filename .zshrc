source ~/.shell_common.sh

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

export NVM_DIR="$HOME/.nvm"
  [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
  [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
