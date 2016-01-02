
echo "Howdy from bash_profile"

# set non-exported variables
NEW_HOSTNAME=`hostname -s`
PROMPT_COMMAND='CurDir=`pwd|sed -E "s!$HOME!~!"|sed -E -e "s!([^/])[^/]+/!\1/!g"`'
PS1="[$NEW_HOSTNAME:\$CurDir] \$ "
PS1='\[\e[0;32m\]$NEW_HOSTNAME\[\e[m\]\[\e[1;32m\]:\[\e[m\]\[\e[1;34m\]$CurDir\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '


# sourcing
test -f ~/.bashrc && . ~/.bashrc
test -f ~/.umobjstorerc && . ~/.umobjstorerc
test -f ~/env/bin/activate && . ~/env/bin/activate
test -f ~/.bash_aliases && . ~/.bash_aliases
test -f ~/.bash_custom_prompt && . ~/.bash_custom_prompt
test -f ~/.todo_completion && . ~/.todo_completion
