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
alias root='sudo bash --rcfile ~/.bashrc'

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

direnv_shell_prompt() {
  [ -n "${DIRENV_FILE:-}" ] && printf '(direnv) '
}

kubectl_shell_prompt() {
  command -v kubectl >/dev/null 2>&1 || return
  kubectl config current-context 2>/dev/null || return
}

__prompt_newline() {
  [ -t 0 ] && [ -t 1 ] || return

  local old_stty response col
  old_stty="$(stty -g 2>/dev/null)" || return
  stty raw -echo min 0 time 1 2>/dev/null || return
  printf '\033[6n' >/dev/tty
  IFS=';' read -r -d R response col </dev/tty
  stty "$old_stty" 2>/dev/null || return

  col="${col%%[!0-9]*}"
  [ -n "$col" ] && [ "$col" -ne 1 ] && printf '\n'
}

__prompt() {
  local exit_code=$?
  local branch
  local direnv_prompt
  local kube_context
  local color_def='\[\e[0m\]'
  local color_date='\[\e[33m\]'
  local color_usr='\[\e[38;5;243m\]'
  local color_direnv='\[\e[38;5;112m\]'
  local color_dir='\[\e[38;5;197m\]'
  local color_git='\[\e[38;5;39m\]'
  local color_kube='\[\e[36m\]'
  __prompt_newline
  branch="$(parse_git_branch)"
  direnv_prompt="$(direnv_shell_prompt)"
  kube_context="$(kubectl_shell_prompt)"
  local code=""
  [ "$exit_code" -ne 0 ] && code=" [$exit_code]"
  [ -n "$branch" ] && branch=" [$branch]"
  [ -n "$kube_context" ] && kube_context=" ${kube_context}"
  PS1="${color_date}\D{%F} \t ${color_usr}\u@\h ${color_direnv}${direnv_prompt}${color_dir}\w ${color_git}${branch}${color_kube}${kube_context}${color_def}${code}\n\$ "
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
