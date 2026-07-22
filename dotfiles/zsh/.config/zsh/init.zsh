setopt autocd extendedglob GLOB_DOTS nobeep INTERACTIVE_COMMENTS NO_CLOBBER RM_STAR_WAIT COMPLETE_IN_WORD AUTO_MENU GLOB_COMPLETE AUTO_PARAM_SLASH NUMERIC_GLOB_SORT LIST_PACKED CDABLE_VARS CHECK_JOBS LONG_LIST_JOBS AUTO_CONTINUE                              

source "$HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.nix-profile/share/fzf/key-bindings.zsh"
source "$HOME/.nix-profile/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval "$(oh-my-posh init zsh --config $ZDOTDIR/oh-my-posh.json)"

for file in $ZDOTDIR/plugins/**/*.zsh(.N); do
    source "$file"
done
