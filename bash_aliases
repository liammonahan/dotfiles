# .bash_aliases
# Created by: Liam Monahan

PLATFORM=`uname -s`

# meta
alias ealias='vim ~/.bash_aliases && . ~/.bash_aliases'

# general aliases
alias ..='cd ..'
alias couldbedoing='$EDITOR $HOME/Documents/things-you-could-be-doing.txt'
alias d3proj="$HOME/usr/bin/d3_project_skeleton.sh"
alias synctovm="rsync -a ~liam/Documents/ liam@vm.liammonahan.com:~liam/Documents/"

# I use this for when I want to see the status of all my git projects kept
# together in a single directory without cd-ing into each one..
alias list_git_statuses='for dir in *; do echo =======$dir======= && git --git-dir=$dir/.git --work-tree=$dir status ; done ;'

# color ls output
if [ $PLATFORM == 'Darwin' ]; then
    alias ls='ls -G'
else
    alias ls='ls --color'
fi

# nota bene
# Arguments:
#   $1 - class
#   $2 - date (optional)
function nb {
  DATETIME=$(date "+%Y-%m-%d")

  # check that a class was passed in
  if [ -z $1 ]; then
    echo "must give class:"
    ls ~/school | grep -e '[0-9][0-9][0-9]'
    return 1
  else
    CLASS="$1"
  fi

  # check that the class is valid
  if [ ! -d ~/school/$CLASS ]; then
    2>1 echo "Class does not exist: $CLASS"
    ls ~/school | grep -e '[0-9][0-9][0-9]'
    return 1
  fi

  # check if a date was passed in 
  if [ ! -z $2 ]; then
    DATETIME=$2
  fi

  if [ -d ~/school/$CLASS/$DATETIME ]; then
    echo "retrieving notes for $DATETIME"
    if [ -f ~/school/$CLASS/$DATETIME/$DATETIME.txt ]; then 
      mvim ~/school/$CLASS/$DATETIME/$DATETIME.txt
    else
      2>1 echo "filestructure is irregular"
    fi
  else
    echo "creating notes for $DATETIME"
    mkdir ~/school/$CLASS/$DATETIME
    cp ~/school/$CLASS/template.txt ~/school/$CLASS/$DATETIME/$DATETIME.txt && mvim ~/school/$CLASS/$DATETIME/$DATETIME.txt
  fi
}

# functions

define () 
{ 
  curl -s dict://dict.org/d:$1 | egrep --color=auto -v "^(220|250|150|151|221)"
}

function cls {
  cd $(echo $*) && ls
}


# todo.txt aliases
export TODOTXT_DEFAULT_ACTION=ls
alias todo='~/usr/bin/todo -d ~/usr/etc/todo/todo.cfg'
alias t='todo'
complete -F _todo todo
complete -F _todo t


# quick and dirty linking service
function linkme() {
  FILE=$1
  [ -z "$FILE" ] && echo please specify a file && exit 1
  if [ $PLATFORM == 'Darwin' ]; then
    MD5=`md5 -q $FILE`
  else
    MD5=`md5sum $FILE | awk '{print $1}'`
  fi
  scp $FILE root@link.monahan.io:/var/www/html/l/$MD5 > /dev/null
  echo http://link.monahan.io/l/$MD5
}
