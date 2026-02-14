
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
pathadd "$HOME/.local/bin"
pathadd "$HOME/usr/bin"
pathadd "/opt/homebrew/opt/libpq/bin"

# programming language local bin directories (if present)
pathadd "$HOME/.cargo/bin"
pathadd "$HOME/.yarn/bin"
pathadd "$HOME/.config/yarn/global/node_modules/.bin"

export PATH

