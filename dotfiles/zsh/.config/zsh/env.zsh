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
export NIXPKGS_ALLOW_UNFREE=1


fpath=(
    "$ZDOTDIR/completions/"
    $fpath
    )
