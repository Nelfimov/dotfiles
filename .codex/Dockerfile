FROM node:24-slim

LABEL org.opencontainers.image.source=https://github.com/Nelfimov/dotfiles
LABEL org.opencontainers.image.documentation=https://raw.githubusercontent.com/Nelfimov/dotfiles/refs/heads/master/.codex/README.md

RUN npm -g install @openai/codex

ENV CODEX_UNSAFE_ALLOW_NO_SANDBOX=1

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  curl \
  dnsutils \
  fzf \
  gh \
  git \
  gnupg2 \
  iproute2 \
  ipset \
  iptables \
  jq \
  less \
  man-db \
  procps \
  unzip \
  ripgrep \
  zsh \
  ca-certificates && \
  rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal --default-toolchain stable

EXPOSE 1455

CMD [ "codex" ]
