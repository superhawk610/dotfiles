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
# - starfetch: command line tool that displays constellations
# - fortune: command for displaying a random quotation
# - lolcat: rainbows and unicorns!
# - pastel: command-line tool to generate, analyze, convert and manipulate colors
# - fd: simple, fast and user-friendly alternative to `find`
#
# ocaml
# - opam: package management system for OCaml
#
# lua
# - luarocks: package manager for Lua
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
# [luarocks]: https://github.com/luarocks/luarocks
# [starfetch]: https://github.com/Haruno19/starfetch
# [fortune]: https://github.com/shlomif/fortune-mod
# [cowsay]: https://github.com/piuccio/cowsay
# [lolcat]: https://github.com/busyloop/lolcat
# [pastel]: https://github.com/sharkdp/pastel
# [fd]: https://github.com/sharkdp/fd

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
LUA_VERSION="5.4.4"
LUAROCKS_VERSION="3.8.0"
FORTUNE_VERSION="3.12.0"
PASTEL_VERSION="0.9.0"
FD_VERSION="8.4.0"

IC_DONE="\033[0;32m✓\033[0m"
IC_INFO="\033[0;2m\033[0m"
IC_FAIL="\033[0;31m\033[0m"

log_done() { echo -e "$IC_DONE $1"; }
log_info() { echo -e "$IC_INFO $1"; }
log_fail() { echo -e "$IC_FAIL $1"; }
log_text() { echo -e "  $1"; }

# these installs _should_ work for both macos/linux *shrug*
LUA_BINARY="lua-${LUA_VERSION}"
LUAROCKS_BINARY="luarocks-${LUAROCKS_VERSION}"
FORTUNE_BINARY="fortune-mod-${FORTUNE_VERSION}"

case $OS in
  mac)
    LUA_PLATFORM="macosx"

    JQ_BINARY="jq-osx-amd64"
    FQ_BINARY="fq_${FQ_VERSION}_macos_amd64"
    RG_BINARY="ripgrep-${RG_VERSION}-x86_64-apple-darwin"
    FX_BINARY="fx-macos"
    BAT_BINARY="bat-v${BAT_VERSION}-x86_64-apple-darwin"
    EXA_BINARY="exa-macos-x86_64-v${EXA_VERSION}"
    OPAM_BINARY="opam-${OPAM_VERSION}-x86_64-macos"
    HEXYL_BINARY="hexyl-v${HEXYL_VERSION}-x86_64-apple-darwin"
    GH_BINARY="gh_${GH_VERSION}_macOS_amd64"
    PASTEL_BINARY="pastel-v${PASTEL_VERSION}-x86_64-apple-darwin"
    FD_BINARY="fd-v${FD_VERSION}-x86_64-apple-darwin"
    ;;

  linux)
    LUA_PLATFORM="linux"

    JQ_BINARY="jq-linux64"
    FQ_BINARY="fq_${FQ_VERSION}_linux_amd64"
    RG_BINARY="ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl"
    FX_BINARY="fx-linux"
    BAT_BINARY="bat-v${BAT_VERSION}-x86_64-unknown-linux-musl"
    EXA_BINARY="exa-linux-x86_64-musl-${EXA_VERSION}"
    OPAM_BINARY="opam-${OPAM_VERSION}-x86_64-linux"
    HEXYL_BINARY="hexyl-v${HEXYL_VERSION}-x86_64-unknown-linux-musl"
    GH_BINARY="gh_${GH_VERSION}_linux_amd64"
    PASTEL_BINARY="pastel-v${PASTEL_VERSION}-x86_64-unknown-linux-musl"
    FD_BINARY="fd-v${FD_VERSION}-x86_64-unknown-linux-musl"
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
  mv "$TMP_DIR/${RG_BINARY}/complete/_rg" "$CMP_DIR"
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

if [ -x "$(command -v luarocks)" ]; then
  log_done "luarocks is already installed!"
else
  log_info "Checking that lua is installed..."

  if ! [ -f "/usr/local/include/lua.h" ]; then
    log_info "can't find lua.h, attempting to build and install lua..."

    log_info "removing existing install, if any..."
    sudo rm -i /usr/bin/lua* /usr/local/bin/lua* || true

    curl -Lo "$TMP_DIR/lua.tar.gz" "http://www.lua.org/ftp/${LUA_BINARY}.tar.gz"
    tar -xzf "$TMP_DIR/lua.tar.gz" -C "$TMP_DIR"
    cd "$TMP_DIR/${LUA_BINARY}"
    make "${LUA_PLATFORM}" test && sudo make install

    log_done "lua installed!"
  fi

  log_info "Installing luarocks..."

  curl -Lo "$TMP_DIR/luarocks.tar.gz" "https://luarocks.org/releases/${LUAROCKS_BINARY}.tar.gz"
  tar -xpzf "$TMP_DIR/luarocks.tar.gz" -C "$TMP_DIR"
  cd "$TMP_DIR/${LUAROCKS_BINARY}"
  ./configure --with-lua-include=/usr/local/include && make && sudo make install

  log_done "luarocks installed!"
fi

if [ -x "$(command -v starfetch)" ]; then
  log_done "starfetch is already installed!"
else
  log_info "Installing starfetch..."

  git clone https://github.com/Haruno19/starfetch "$TMP_DIR/starfetch"
  cd "$TMP_DIR/starfetch"
  make

  case $OS in
    mac) sudo make install_mac;;
    linux) sudo make install;;
  esac

  log_done "starfetch installed!"
fi

if [ -x "$(command -v fortune)" ]; then
  log_done "fortune is already installed!"
elif ! [ -x "$(command -v cmake)" ]; then
  log_fail "cmake is required"
else
  log_info "Installing fortune..."

  curl -Lo "$TMP_DIR/fortune.tar.xz" "https://github.com/shlomif/fortune-mod/releases/download/${FORTUNE_BINARY}/${FORTUNE_BINARY}.tar.xz"
  tar -xf "$TMP_DIR/fortune.tar.xz" -C "$TMP_DIR"
  cd "$TMP_DIR/${FORTUNE_BINARY}"
  mkdir build
  cd build
  cmake ..
  sudo make install
  ln -s /usr/local/games/fortune "$BIN_DIR/fortune"
  cd ..
  sudo rm -rf build

  log_done "fortune installed!"
fi

if [ -x "$(command -v cowsay)" ]; then
  log_done "cowsay is already installed!"
else
  log_info "Installing cowsay..."
  npm install -g cowsay
  log_done "cowsay installed!"
fi

if [ -x "$(command -v lolcat)" ]; then
  log_done "lolcat is already installed!"
else
  log_info "Installing lolcat..."
  gem install lolcat
  log_done "lolcat installed!"
fi

if [ -x "$(command -v pastel)" ]; then
  log_done "pastel is already installed!"
else
  log_info "Installing pastel..."

  curl -Lo "$TMP_DIR/pastel.tar.gz" "https://github.com/sharkdp/pastel/releases/download/v${PASTEL_VERSION}/${PASTEL_BINARY}.tar.gz"
  tar -xzf "$TMP_DIR/pastel.tar.gz" -C "$TMP_DIR"
  mv "$TMP_DIR/${PASTEL_BINARY}/pastel" "$BIN_DIR/pastel"

  log_done "pastel installed!"
fi

if [ -x "$(command -v fd)" ]; then
  log_done "fd is already installed!"
else
  log_info "Installing fd..."

  curl -Lo "$TMP_DIR/fd.tar.gz" "https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/${FD_BINARY}.tar.gz"
  tar -xzf "$TMP_DIR/fd.tar.gz" -C "$TMP_DIR"
  mv "$TMP_DIR/${FD_BINARY}/fd" "$BIN_DIR/fd"
  mv "$TMP_DIR/${FD_BINARY}/fd.1" "$MN1_DIR"
  mv "$TMP_DIR/${FD_BINARY}/autocomplete/_fd" "$CMP_DIR"

  log_done "fd installed!"
fi

# ---

rm -rf "$TMP_DIR"
