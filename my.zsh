export LANG=en_US.UTF-8
#jdk
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
export JAVA_11_HOME=$(/usr/libexec/java_home -v 11)
export JAVA_17_HOME=$(/usr/libexec/java_home -v 17)
export JAVA_21_HOME=$(/usr/libexec/java_home -v 21)
export JAVA_23_HOME=$(/usr/libexec/java_home -v 23)

alias java23='export JAVA_HOME=$JAVA_23_HOME'
alias java11='export JAVA_HOME=$JAVA_11_HOME'
alias java21='export JAVA_HOME=$JAVA_21_HOME'
alias java17='export JAVA_HOME=$JAVA_17_HOME'

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

