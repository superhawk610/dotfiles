# minimal ZSH environment (safe to run on a clean install)

# path
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# editor
export EDITOR=nvim

# term
# needed by `pastel` to avoid a warning
export COLORTERM=truecolor
