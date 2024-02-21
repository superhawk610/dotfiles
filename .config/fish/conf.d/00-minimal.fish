# path
fish_add_path ~/scripts
fish_add_path ~/.local/bin

# editor
export EDITOR=nvim

# needed by `pastel` to avoid a warning
export COLORTERM=truecolor

# enable full color
export TERM=xterm-256color

# determine OS ----------------

switch (uname)
  case Linux
    set -g OS linux
  case Darwin
    set -g OS mac
  case '*'
    set -g OS unknown
end

function on_mac
  [ "$OS" = "mac" ]
end

function on_linux
  [ "$OS" = "linux" ]
end

function on_wsl
  [ -f "/proc/version" ] && grep -qEi '(Microsoft|WSL)' /proc/version
end
