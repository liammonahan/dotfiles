
echo "howdy from bash_profile"

# set non-exported variables
NEW_HOSTNAME=`hostname -s`
PROMPT_COMMAND='CurDir=`pwd|sed -E "s!$HOME!~!"|sed -E -e "s!([^/])[^/]+/!\1/!g"`'
PS1="[$NEW_HOSTNAME:\$CurDir] \$ "
PS1='\[\e[0;32m\]$NEW_HOSTNAME\[\e[m\]\[\e[1;32m\]:\[\e[m\]\[\e[1;34m\]$CurDir\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '


# sourcing
test -f ~/.bashrc && . ~/.bashrc
test -f ~/.localrc && . ~/.localrc
test -f ~/.git-completion.bash && . ~/.git-completion.bash
test -f ~/.umobjstorerc && . ~/.umobjstorerc
test -f ~/env/bin/activate && . ~/env/bin/activate
test -f ~/.bash_aliases && . ~/.bash_aliases
test -f ~/.bash_custom_prompt && . ~/.bash_custom_prompt
test -f ~/.todo_completion && . ~/.todo_completion


_complete_hosts () {
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"

    host_list=`{
        cat ~/.hostslist
    } | tr ' ' '\n'`
    COMPREPLY=($(compgen -W "${host_list}" -- $cur))
    return 0
}
complete -o default -F _complete_hosts ssh sshh nslookup scp ssh-copy-id
complete -F _complete_hosts host


function add_host_to_autocomplete () {
    host=$1
    grep $host ~/.hostslist > /dev/null
    [[ $? -eq 0 ]] && echo "$host already exists in the list" && return 0
    echo $1 >> ~/.hostslist
    sort ~/.hostslist | uniq > ~/.hostslist-tmp
    mv ~/.hostslist-tmp ~/.hostslist
}
