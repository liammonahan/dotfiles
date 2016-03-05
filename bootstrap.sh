#!/bin/sh

# This script makes backup copies of any existing dotfiles into a folder called
# "oiginals" and then symlinks all dotfiles to the copies held in this repo.

DOTFILES_REPO_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ORIGINALS=$DOTFILES_REPO_LOCATION/originals
FILES=( bash_profile bashrc bash_aliases vimrc screenrc )

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
