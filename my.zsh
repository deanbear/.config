#rabbitPro
export https_proxy=http://127.0.0.1:7897
export http_proxy=http://127.0.0.1:7897
export all_proxy=socks5://127.0.0.1:7897

#auto-suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#fzf
export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border --info=inline'
source <(fzf --zsh)

#XDG_CONFIG
export XDG_CONFIG_HOME=$HOME/.config


#aliases
alias vim='nvim'
alias nvimdiff='nvim -d'
alias rfv='sh ~/.config/rfv.sh'

