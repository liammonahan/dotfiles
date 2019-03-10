
# set exported variables
export EDITOR=vim

NPM_PACKAGES="${HOME}/.npm-packages"

PATH="$NPM_PACKAGES/bin:$PATH"
PATH=/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH
PATH=$HOME/usr/bin:$PATH
PATH=/opt/local/bin:/opt/local/sbin:$PATH  # macports addition
export PATH
