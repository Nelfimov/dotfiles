source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
zstyle -e ':autocomplete:*:*' list-lines 'reply=( $(( LINES / 2 )) )'
bindkey -M menuselect  '^[[D' .backward-char  '^[OD' .backward-char
bindkey -M menuselect  '^[[C'  .forward-char  '^[OC'  .forward-char

plugins=(git)

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

## SSH Config File Completion
h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
fi

# /SSH

## GPG
export GPG_TTY=$(tty)

# /GPG

## Flutter
export PATH="$PATH:/Users/nikoroach/Documents/IDE/flutter/bin"

# /Flutter

if [ -f $(brew --prefix)/etc/zsh_completion ]; then
. $(brew --prefix)/etc/zsh_completion
fi

## The next line updates PATH for Yandex Cloud CLI.
if [ -f '/Users/nikoroach/yandex-cloud/path.bash.inc' ]; then source '/Users/nikoroach/yandex-cloud/path.bash.inc'; fi

## The next line enables shell command completion for yc.
if [ -f '/Users/nikoroach/yandex-cloud/completion.zsh.inc' ]; then source '/Users/nikoroach/yandex-cloud/completion.zsh.inc'; fi

export PATH="/opt/homebrew/opt/node@20/bin:$PATH"

## [Completion] 
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/nikoroach/.dart-cli-completion/zsh-config.zsh ]] && . /Users/nikoroach/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

## Ruby
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi

export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
 
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

## Aliases

alias g='git'

alias obsidian='cd ~/Documents/Dev/Obsidian/work && nvim'
alias dotfiles='cd ~/Documents/Dev/Nelfimov/nelfimov-dotfiles && nvim'

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

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

