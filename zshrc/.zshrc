PS1="%(?.✓.X) %n %1~ %# "

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# User Aliases
alias vim="nvim"
alias da="ls -la"
alias nvimconfig="cd ~/.config/nvim"
alias cls="clear"

source "$HOME/.zshrc-`uname`"

# Source local env secrets file.
if [ -f "$HOME/.zshrc-env" ]; then
    source "$HOME/.zshrc-env"
else
    echo ".zshrc-env not found."
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
