PS1='\[\033]0;bash: \W\007\]'  # set window title

PS1="$PS1"'\n'                 # newline before next prompt

function nonzero_exit() {
  exit_code="$?"
  [[ "$exit_code" -ne "0" ]] && echo " (exit:$exit_code) "
}

PS1="$PS1"'\[\033[41m\]'       # change to red bg
PS1="$PS1"'\[\033[39m\]'       # change to black
PS1="$PS1"'$(nonzero_exit)'    # display non-zero exit codes

PS1="$PS1"'\[\033[42m\]'       # change to green bg
PS1="$PS1"'\[\033[30m\]'       # change to black
PS1="$PS1"' [PC] '             # device tag

PS1="$PS1"'\[\033[40m\]'       # change to black bg
PS1="$PS1"'\[\033[32m\]'       # change to green
PS1="$PS1"' \u '               # username

PS1="$PS1"'\[\033[44m\]'       # change to blue bg
PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
PS1="$PS1"' \w '               # current working directory

function virtualenv_info() {
  # Get virtualenv
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # Strip out path leaving env name
    venv=$(basename "$VIRTUAL_ENV")
  else
    # In case no virtualenv is active
    venv=''
  fi
  [[ -n "$venv" ]] && echo " (venv:$venv) "
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

PS1="$PS1"'\[\033[43m\]'       # change to yellow bg
PS1="$PS1"'\[\033[30m\]'       # change to black
PS1="$PS1"'$(virtualenv_info)' # virtualenv name

if test -z "$WINELOADERNOEXEC"
then
  GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
  COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
  COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
  COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
  if test -f "$COMPLETION_PATH/git-prompt.sh"
  then
    . "$COMPLETION_PATH/git-completion.bash"
    . "$COMPLETION_PATH/git-prompt.sh"
    PS1="$PS1"'\[\033[45m\]'   # change to purple bg
    PS1="$PS1"'\[\033[30m\]'   # change to black
    PS1="$PS1"'`__git_ps1`'    # bash function
  fi
fi

function echoprompt() {
  prompt='→ '                  # arrow prompt
  # prompt='λ '                # lambda prompt
  # prompt='┗━ % '             # right angle prompt
  echo -e "\n$prompt"
}

PS1="$PS1"'\[\033[0m\]'        # reset color
PS1="$PS1"'$(echoprompt)'      # prompt (this is a function since echoing
                               # newlines directly in the prompt breaks
                               # real-time command substitution, which is
                               # required for virtualenv path output
