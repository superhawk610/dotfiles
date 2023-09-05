# minimal ZSH environment (safe to run on a clean install)

# path
export PATH=$PATH:~/scripts
export PATH=$PATH:~/.local/bin

# editor
export EDITOR=nvim

# term
# needed by `pastel` to avoid a warning
export COLORTERM=truecolor
