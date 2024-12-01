
# these color settings only take effect on MacOS
export LSCOLORS=GxFxCxDxBxegedabagaced

# set exported variables
export EDITOR=vim

# Function for adding directories to PATH
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1${PATH:+":$PATH"}"
    fi
}

pathadd "$HOME/.dotfiles/bin"
pathadd /Applications/Xcode.app/Contents/Developer/usr/bin
pathadd $HOME/usr/bin
pathadd /opt/local/bin   # macports addition
pathadd /opt/local/sbin  # macports addition

# programming language local bin directories (if present)
pathadd "$HOME/.cargo/bin"
pathadd "$HOME/.poetry/bin"
pathadd "$HOME/.local/bin"
pathadd "$HOME/.yarn/bin"
pathadd "$HOME/.config/yarn/global/node_modules/.bin"
pathadd "$HOME/.rvm/bin"

export PATH

