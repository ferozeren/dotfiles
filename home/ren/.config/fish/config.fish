source /usr/share/cachyos-fish-config/cachyos-config.fish

set -x EDITOR helix

# Paths

# Cargo binary Path
fish_add_path ~/.cargo/bin/

# Flutter SDK Path
fish_add_path -g -p ~/development/flutter/bin

export CHROME_EXECUTABLE="/bin/google-chrome-stable"

# Aliases

alias hx=helix
alias nv=nvim
alias cht="cht.sh"
function hxniri
    hx ~/.config/niri/config.kdl
end
function hxfish
    hx ~/.config/fish/config.fish
end

function uwu
    sudo pacman -Syy
    sudo pacman -Syu
    paru -Syu
end

# Application Config

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

abbr --erase z &>/dev/null
alias z=__zoxide_z

abbr --erase zi &>/dev/null
alias zi=__zoxide_zi

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually
# ~/.config/fish/config.fish):
#
zoxide init fish | source

## Starship

starship init fish | source

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
