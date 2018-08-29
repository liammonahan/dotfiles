
echo "howdy from bash_profile"

# set non-exported variables
NEW_HOSTNAME=`hostname -s`
PROMPT_COMMAND='CurDir=`pwd|sed -E "s!$HOME!~!"|sed -E -e "s!([^/])[^/]+/!\1/!g"`'
PS1="[$NEW_HOSTNAME:\$CurDir] \$ "
PS1='\[\e[0;32m\]$NEW_HOSTNAME\[\e[m\]\[\e[1;32m\]:\[\e[m\]\[\e[1;34m\]$CurDir\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '

# Function for adding directories to PATH
pathadd() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1${PATH:+":$PATH"}"
  fi
}

# Function for sourcing files only if they exist
source_if_exists() {
  test -f "$1" && source "$1"
}

# sourcing
source_if_exists ~/.bashrc
source_if_exists ~/.localrc
source_if_exists ~/.git-completion.bash
source_if_exists ~/.umobjstorerc
source_if_exists ~/.bash_aliases
source_if_exists ~/.bash_custom_prompt
source_if_exists ~/.todo_completion
source_if_exists ~/.exercism_completion


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


export PATH="$HOME/.cargo/bin:$PATH"
