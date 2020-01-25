# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Add wisely, as too many plugins slow down shell startup.
plugins=(kubectl nvm)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

[ -s "${HOME}/.jabba/jabba.sh" ] && source "${HOME}/.jabba/jabba.sh"

# Start GNOME Keyring, if applicable
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

# Add zplugin support
source "${HOME}/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# Plugins
zplugin load zsh-users/zsh-autosuggestions
zplugin load zsh-users/zsh-syntax-highlighting

eval "$(starship init zsh)"

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin
