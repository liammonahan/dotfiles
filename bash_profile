
echo "howdy from bash_profile"

# set non-exported variables
NEW_HOSTNAME=`hostname -s`
PROMPT_COMMAND='CurDir=`pwd|sed -E "s!$HOME!~!"|sed -E -e "s!([^/])[^/]+/!\1/!g"`'
PS1="[$NEW_HOSTNAME:\$CurDir] \$ "
PS1='\[\e[0;32m\]$NEW_HOSTNAME\[\e[m\]\[\e[1;32m\]:\[\e[m\]\[\e[1;34m\]$CurDir\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '

# Function for sourcing files only if they exist
source_if_exists() {
  test -f "$1" && source "$1"
}

# sourcing
source_if_exists ~/.bashrc
source_if_exists ~/.localrc
source_if_exists ~/.dotfiles/completions/bash/git-completion.bash
source_if_exists ~/.bash_aliases
source_if_exists ~/.bash_custom_prompt
source_if_exists ~/.todo_completion
source_if_exists ~/.exercism_completion
source_if_exists ~/.cargo/env

# readline operating in vi mode
set -o vi

_complete_hosts () {
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"

    host_list=`{
        cat ~/.hostslist
    } | tr ' ' '\n'`
    COMPREPLY=($(compgen -W "${host_list}" -- $cur))
    return 0
}
complete -F _complete_hosts host ssh nslookup ssh-copy-id

_pipenv_completion() {
    local IFS=$'\t'
    COMPREPLY=( $( env COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   _PIPENV_COMPLETE=complete-bash $1 ) )
    return 0
}

complete -F _pipenv_completion -o default pipenv

# Silence warning about using bash on macOS.
export BASH_SILENCE_DEPRECATION_WARNING=1

# warn about uncommitted dotfiles
git --git-dir "$HOME/.dotfiles/.git" --work-tree "$HOME/.dotfiles" diff --quiet || echo "~~~ dotfiles have uncommitted changes ~~~"
