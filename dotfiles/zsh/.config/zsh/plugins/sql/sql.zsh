sql(){
    local script="$(bun run $ZDOTDIR/plugins/sql/sql.ts)"
    eval "$script"
}
