
# these color settings only take effect on MacOS
export LSCOLORS=GxFxCxDxBxegedabagaced

# set exported variables
export EDITOR=vim

NPM_PACKAGES="${HOME}/.npm-packages"

pathadd "$NPM_PACKAGES/bin"
pathadd /Applications/Xcode.app/Contents/Developer/usr/bin
pathadd $HOME/usr/bin
pathadd /opt/local/bin   # macports addition
pathadd /opt/local/sbin  # macports addition
pathadd "$HOME/.cargo/bin"

export PATH
