#!/usr/bin/env sh

export HISTSIZE=5000
export HISTFILESIZE="$HISTSIZE"
if [ -n "$BASH_VERSION" ]; then
  export HISTCONTROL="ignoredups:erasedups"
fi

if [ -t 0 ]; then
  export GPG_TTY="$(tty)"
fi

export K9S_CONFIG_DIR="$HOME/.config/k9s/"
export KUBE_EDITOR=nvim
export EDITOR=nvim

ulimit -n 4096 2>/dev/null || true

# Aliases
if ls --color >/dev/null 2>&1; then
  alias ls='ls --color'
fi

alias obsidian='cd ~/Documents/Dev/Obsidian && nvim'
alias dotfiles='cd ~/Documents/Dev/dotfiles && nvim'

alias tf='terraform'
alias tfi='terraform init && terraform providers lock -platform=linux_amd64'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tff='terraform fmt'

alias k='kubectl'
alias kx='kubectl exec -it'
alias kg='kubectl get'
alias kge='kubectl get events --sort-by=".lastTimestamp"'
alias kl='kubectl logs'

dev() {
  session_name="$(basename "$PWD")"
  nix develop -c zellij a --create "$session_name" "$@"
}

compress_video() {
  ffmpeg -i "$1" \
    -vf "fps=15,scale=1500:-1:flags=lanczos,palettegen" \
    ~/Desktop/palette.png &&
    ffmpeg -i "$1" \
      -i ~/Desktop/palette.png \
      -filter_complex "fps=15,scale=1500:-1:flags=lanczos[x];[x][1:v]paletteuse=dither=bayer" \
      -loop 0 \
      ~/Desktop/output.gif &&
    rm -rf ~/Desktop/palette.png
}

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
