source "$ZDOTDIR/env.zsh"

# Lines configured by zsh-newuser-install
HISTFILE="$ZDOTDIR/.histfile"
HISTSIZE=50000
SAVEHIST=50000
setopt autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/g1d3onFr0st/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
source "$HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.nix-profile/share/fzf/key-bindings.zsh"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"


source "$ZDOTDIR/init.zsh"
source "$ZDOTDIR/history.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/keybinds.zsh"
source "$ZDOTDIR/plugins.zsh"
source "$ZDOTDIR/setopt.zsh"
source "$ZDOTDIR/completion.zsh"

add(){
echo "$0"  >> ~/local-bin.txt
}
