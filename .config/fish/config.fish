if status is-interactive
  # do interactive stuff here!

  function fish_greeting
    switch (random 1 10)
      # display a random constellation!
      case 1 2 3 4
        [ -x "$(command -v starfetch)" ] && starfetch
      case 5
        [ -x "$(command -v starfetch)" ] && starfetch | lolcat

      # say something profound
      case 6 7 8
        [ -x "$(command -v fortune)" ] && fortune | cowsay -W80
      case 9
        [ -x "$(command -v fortune)" ] && fortune | cowsay -W80 -r
      case 10
        [ -x "$(command -v fortune)" ] && fortune | cowsay -W80 -r | lolcat
    end
  end
end
