#!/bin/sh

git submodule init
git submodule update

# This script makes backup copies of any existing dotfiles into a folder called
# "originals" and then symlinks all dotfiles to the copies held in this repo.

DOTFILES_REPO_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ORIGINALS=$DOTFILES_REPO_LOCATION/originals
FILES=( bash_profile bashrc bash_aliases vimrc screenrc gitconfig gitignore_global tmux.conf)

mkdir -p $ORIGINALS

for file in ${FILES[@]};
do
    if [ -f ~/.$file ]; then
        # make a backup of any existing dotfiles
        cp ~/.$file $ORIGINALS/$file
        rm -f ~/.$file
    fi
    ln -s $DOTFILES_REPO_LOCATION/$file ~/.$file
done

[ ! -d $DOTFILES_REPO_LOCATION/local ] && git clone git@github.com:liammonahan/dotfiles-local.git $DOTFILES_REPO_LOCATION/local && echo "you may want to set a preferred branch"
