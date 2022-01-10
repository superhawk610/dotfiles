#!/bin/bash
set -euo pipefail

# This script installs common utility binaries, skipping them if they're
# already present in your $PATH. Here are the binaries w/ descriptions:
#
# - jq: command-line JSON processor
# - fq: command-line binary data processor, a la jq (archives, images, etc.)
# - yq: command-line YAML/XML/TOML processor, a la jq
# - rg: grep(1) with a kick in the pants
# - bat: a cat(1) clone with wings
# - fzf: a command-line fuzzy finder
# - exa: a modern replacement for `ls`
#
# ocaml
#
# - opam: package management system for OCaml
#
# [jq]: https://github.com/stedolan/jq
# [fq]: https://github.com/wader/fq
# [yq]: https://github.com/kislyuk/yq
# [rg]: https://github.com/BurntSushi/ripgrep
# [bat]: https://github.com/sharkdp/bat
# [fzf]: https://github.com/junegunn/fzf
# [exa]: https://github.com/ogham/exa
# [opam]: https://github.com/ocaml/opam

TMP_DIR="/tmp/bins"
BIN_DIR="$HOME/.local/bin"
MAN_DIR="$BIN_DIR/../share/man"
MN1_DIR="$MAN_DIR/man1"
MN5_DIR="$MAN_DIR/man5"
CMP_DIR="$ZSH/completions"

JQ_VERSION="1.6"
FQ_VERSION="0.0.2"
YQ_VERSION="2.13.0"
RG_VERSION="13.0.0"
BAT_VERSION="0.18.3"
EXA_VERSION="0.10.1"
OPAM_VERSION="2.1.2"

IC_DONE="\033[0;32m✓\033[0m"
IC_INFO="\033[0;2m\033[0m"

log_done() { echo -e "$IC_DONE $1"; }
log_info() { echo -e "$IC_INFO $1"; }

case $OS in
  mac)
    JQ_BINARY="jq-osx-amd64"
    FQ_BINARY="fq_${FQ_VERSION}_macos_amd64"
    RG_BINARY="ripgrep-${RG_VERSION}-x86_64-apple-darwin"
    BAT_BINARY="bat-v${BAT_VERSION}-x86_64-apple-darwin"
    EXA_BINARY="exa-macos-x86_64-v${EXA_VERSION}"
    OPAM_BINARY="opam-${OPAM_VERSION}-x86_64-macos"
    ;;

  linux)
    JQ_BINARY="jq-linux64"
    FQ_BINARY="fq_${FQ_VERSION}_linux_amd64"
    RG_BINARY="ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl"
    BAT_BINARY="bat-v${BAT_VERSION}-x86_64-unknown-linux-musl"
    EXA_BINARY="exa-linux-x86_64-musl-${EXA_VERSION}"
    OPAM_BINARY="opam-${OPAM_VERSION}-x86_64-linux"
    ;;

  *)
    echo "unable to determine operating system, is \$OS set?"
    exit 1
    ;;
esac

mkdir -p "$TMP_DIR" "$MN1_DIR" "$MN5_DIR" "$CMP_DIR"

# ---

if [ -x "$(command -v jq)" ]; then
  log_done "jq is already installed!"
else
  log_info "Installing jq..."
  curl -Lo "$TMP_DIR/jq" "https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/${JQ_BINARY}"
  mv "$TMP_DIR/jq" "$BIN_DIR/jq"
  chmod +x "$BIN_DIR/jq"
  log_done "jq installed!"
fi

if [ -x "$(command -v fq)" ]; then
  log_done "fq is already installed!"
else
  log_info "Installing fq..."
  curl -Lo "$TMP_DIR/fq.tar.gz" "https://github.com/wader/fq/releases/download/v${FQ_VERSION}/${FQ_BINARY}.tar.gz"
  tar -xzf "$TMP_DIR/fq.tar.gz" -C "$TMP_DIR"
  mv "$TMP_DIR/fq" "$BIN_DIR/fq"
  chmod +x "$BIN_DIR/fq"
  log_done "fq installed!"
fi

if [ -x "$(command -v yq)" ]; then
  log_done "yq is already installed!"
else
  log_info "Installing yq..."
  pip3 install --user "yq==${YQ_VERSION}"
  log_done "yq installed!"
fi

if [ -x "$(command -v rg)" ]; then
  log_done "rg is already installed!"
else
  log_info "Installing rg..."
  curl -Lo "$TMP_DIR/rg.tar.gz" "https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/${RG_BINARY}.tar.gz"
  tar -xzf "$TMP_DIR/rg.tar.gz" -C "$TMP_DIR"
  mv "$TMP_DIR/${RG_BINARY}/doc/rg.1" "$MN1_DIR"
  mv "$TMP_DIR/${RG_BINARY}/rg" "$BIN_DIR/rg"
  chmod +x "$BIN_DIR/rg"
  log_done "rg installed!"
fi

if [ -x "$(command -v bat)" ]; then
  log_done "bat is already installed!"
else
  log_info "Installing bat..."
  curl -Lo "$TMP_DIR/bat.tar.gz" "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/${BAT_BINARY}.tar.gz"
  tar -xzf "$TMP_DIR/bat.tar.gz" -C "$TMP_DIR"
  mv "$TMP_DIR/${BAT_BINARY}/bat.1" "$MN1_DIR"
  mv "$TMP_DIR/${BAT_BINARY}/bat" "$BIN_DIR/bat"
  chmod +x "$BIN_DIR/bat"
  log_done "bat installed!"
fi

if [ -x "$(command -v fzf)" ]; then
  log_done "fzf is already installed!"
else
  log_info "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --key-bindings --completion --no-update-rc
  log_done "fzf installed!"
fi

if [ -x "$(command -v exa)" ]; then
  log_done "exa is already installed!"
else
  log_info "Installing exa..."
  curl -Lo "$TMP_DIR/exa.zip" "https://github.com/ogham/exa/releases/download/v${EXA_VERSION}/${EXA_BINARY}.zip"
  unzip -d "$TMP_DIR/exa" "$TMP_DIR/exa.zip"
  mv "$TMP_DIR/exa/man/exa.1" "$MN1_DIR"
  mv "$TMP_DIR/exa/man/exa_colors.5" "$MN5_DIR"
  mv "$TMP_DIR/exa/completions/exa.zsh" "$CMP_DIR"
  mv "$TMP_DIR/exa/bin/exa" "$BIN_DIR/exa"
  chmod +x "$BIN_DIR/exa"
  log_done "exa installed!"
fi

if [ -x "$(command -v opam)" ]; then
  log_done "opam is already installed!"
else
  curl -Lo "$BIN_DIR/opam" "https://github.com/ocaml/opam/releases/download/${OPAM_VERSION}/${OPAM_BINARY}"
  chmod +x "$BIN_DIR/opam"
  log_done "opam installed! run \`opam init\` to get started"
fi

# ---

rm -rf "$TMP_DIR"
