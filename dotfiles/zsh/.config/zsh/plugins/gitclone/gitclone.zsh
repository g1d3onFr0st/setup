gitclone(){
    local script=$(bun run "$ZDOTDIR/plugins/gitclone/gitclone.ts" "$@") 
    zsh -c "$script"
}

