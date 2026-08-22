sudon() {
    (( $# )) || {
        echo "usage: sudon <command> [args...]"
        return 1
    }

    local cmd="$1"
    shift
    sudo "$HOME/.nix-profile/bin/$cmd" "$@"
}
