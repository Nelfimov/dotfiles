shopt -s histappend cmdhist checkwinsize
export HISTSIZE=50000
export HISTFILESIZE=100000
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT='%F %T '

PROMPT_COMMAND='history -a; history -n; '"${PROMPT_COMMAND:-}"

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
elif command -v vim >/dev/null 2>&1; then
  export EDITOR=vim
else
  export EDITOR=vi
fi

export LESS='-R -F -X'
export MANPAGER='less -R'

parse_git_branch() {
  git symbolic-ref --short HEAD 2>/dev/null
}

__prompt() {
  local exit_code=$?
  local branch
  branch="$(parse_git_branch)"
  local code=""
  [ "$exit_code" -ne 0 ] && code=" [$exit_code]"
  [ -n "$branch" ] && branch=" [$branch]"
  PS1="\u@\h \w${branch}${code}\n\$ "
}
PROMPT_COMMAND="__prompt; ${PROMPT_COMMAND:-}"

if [ -f "$HOME/.shell_common.sh" ]; then
  source "$HOME/.shell_common.sh"
fi

if [[ $- == *i* ]]; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi

  if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --bash)"
  fi

  if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash --cmd cd)"
  fi

  set -o vi

  # Make vi-mode state visible in the prompt.
  if [ -t 0 ]; then
    bind 'set show-mode-in-prompt on'
    bind 'set keyseq-timeout 10'
    bind 'set vi-cmd-mode-string "\1\e[1;31m\2[N]\1\e[0m\2 "'
    bind 'set vi-ins-mode-string "\1\e[1;32m\2[I]\1\e[0m\2 "'
  fi

  # Aliases
  if ls --color >/dev/null 2>&1; then
    alias ls='ls --color'
    if ls --hyperlink=auto >/dev/null 2>&1; then
      alias ls='ls --color --hyperlink=auto'
    fi
  fi
fi
