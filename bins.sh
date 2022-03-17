#!/bin/bash
set -euo pipefail

# This script installs common utility binaries, skipping them if they're
# already present in your $PATH. Here are the binaries w/ descriptions:
#
# - jq: command-line JSON processor
# - fq: command-line binary data processor, a la jq (archives, images, etc.)
# - yq/xq/tomlq: command-line YAML/XML/TOML processor, a la jq
# - rg: grep(1) with a kick in the pants
# - fx: command-line tool and terminal JSON viewer
# - bat: a cat(1) clone with wings
# - fzf: a command-line fuzzy finder
# - exa: a modern replacement for `ls`
# - hexyl: a command-line hex viewer
# - gh: GitHub's official command-line tool
#
# ocaml
#
# - opam: package management system for OCaml
#
# [jq]: https://github.com/stedolan/jq
# [fq]: https://github.com/wader/fq
# [yq]: https://github.com/kislyuk/yq
# [rg]: https://github.com/BurntSushi/ripgrep
# [fx]: https://github.com/antonmedv/fx
# [bat]: https://github.com/sharkdp/bat
# [fzf]: https://github.com/junegunn/fzf
# [exa]: https://github.com/ogham/exa
# [hexyl]: https://github.com/sharkdp/hexyl
# [opam]: https://github.com/ocaml/opam
# [gh]: https://github.com/cli/cli

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
FX_VERSION="20.0.2"
BAT_VERSION="0.18.3"
EXA_VERSION="0.10.1"
OPAM_VERSION="2.1.2"
HEXYL_VERSION="0.9.0"
GH_VERSION="2.6.0"

IC_DONE="\033[0;32m✓\033[0m"
IC_INFO="\033[0;2m\033[0m"

log_done() { echo -e "$IC_DONE $1"; }
log_info() { echo -e "$IC_INFO $1"; }
log_text() { echo -e "  $1"; }

case $OS in
  mac)
    JQ_BINARY="jq-osx-amd64"
    FQ_BINARY="fq_${FQ_VERSION}_macos_amd64"
    RG_BINARY="ripgrep-${RG_VERSION}-x86_64-apple-darwin"
    FX_BINARY="fx-macos"
    BAT_BINARY="bat-v${BAT_VERSION}-x86_64-apple-darwin"
    EXA_BINARY="exa-macos-x86_64-v${EXA_VERSION}"
    OPAM_BINARY="opam-${OPAM_VERSION}-x86_64-macos"
    HEXYL_BINARY="hexyl-v${HEXYL_VERSION}-x86_64-apple-darwin"
    GH_BINARY="gh_${GH_VERSION}_macOS_amd64"
    ;;

  linux)
    JQ_BINARY="jq-linux64"
    FQ_BINARY="fq_${FQ_VERSION}_linux_amd64"
    RG_BINARY="ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl"
    FX_BINARY="fx-linux"
    BAT_BINARY="bat-v${BAT_VERSION}-x86_64-unknown-linux-musl"
    EXA_BINARY="exa-linux-x86_64-musl-${EXA_VERSION}"
    OPAM_BINARY="opam-${OPAM_VERSION}-x86_64-linux"
    HEXYL_BINARY="hexyl-v${HEXYL_VERSION}-x86_64-unknown-linux-musl"
    GH_BINARY="gh_${GH_VERSION}_linux_amd64"
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
  log_done "yq/xq/tomlq are already installed!"
else
  log_info "Installing yq/xq/tomlq..."
  pip3 install --user "yq==${YQ_VERSION}"
  log_done "yq/xq/tomlq installed!"
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

if [ -x "$(command -v hexyl)" ]; then
  log_done "hexyl is already installed!"
else
  log_info "Installing hexyl..."
  curl -Lo "$TMP_DIR/hexyl.tar.gz" "https://github.com/sharkdp/hexyl/releases/download/v${HEXYL_VERSION}/${HEXYL_BINARY}.tar.gz"
  tar -xzf "$TMP_DIR/hexyl.tar.gz" -C "$TMP_DIR"
  mv "$TMP_DIR/${HEXYL_BINARY}/hexyl" "$BIN_DIR/hexyl"
  chmod +x "$BIN_DIR/hexyl"
  log_done "hexyl installed!"
fi

if [ -x "$(command -v fx)" ]; then
  log_done "fx is already installed!"
else
  log_info "Installing fx..."
  curl -Lo "$TMP_DIR/fx.zip" "https://github.com/antonmedv/fx/releases/download/${FX_VERSION}/${FX_BINARY}.zip"
  unzip -d "$TMP_DIR" "$TMP_DIR/fx.zip"
  mv "$TMP_DIR/${FX_BINARY}" "$BIN_DIR/fx"
  chmod +x "$BIN_DIR/fx"
  log_done "fx installed!"
fi

if [ -x "$(command -v gh)" ]; then
  log_done "gh is already installed!"
else
  log_info "Installing gh..."
  curl -Lo "$TMP_DIR/gh.tar.gz" "https://github.com/cli/cli/releases/download/v${GH_VERSION}/${GH_BINARY}.tar.gz"
  tar -xzf "$TMP_DIR/gh.tar.gz" -C "$TMP_DIR"
  mv "$TMP_DIR/${GH_BINARY}/share/man/man1/"* "$MN1_DIR"
  mv "$TMP_DIR/${GH_BINARY}/bin/gh" "$BIN_DIR/gh"
  chmod +x "$BIN_DIR/gh"

  log_text ""
  log_text "  install extensions ---"
  log_text "  $ gh extension install dlvhdr/gh-prs"
  log_text ""

  log_done "gh installed!"
fi

# ---

rm -rf "$TMP_DIR"
