typeset -U path PATH

path=(
    "$HOME/.local/bin"
    "$HOME/.nix-profile/bin"
    "/usr/bin/"
    "/usr/local/bin/"
)

export PATH
export EDITOR=nvim
# export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"
export PAGER=bat
export PRIVATE_IP=$(ip -4 route get 1.1.1.1 | awk '{print $7; exit}')
