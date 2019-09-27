# .bash_aliases
# Created by: Liam Monahan

PLATFORM=`uname -s`

# meta
alias ealias='vim ~/.bash_aliases && . ~/.bash_aliases'

# general aliases
alias ll='ls -l'
alias ..='cd ..'
alias d3proj="$HOME/usr/bin/d3_project_skeleton.sh"
alias synctovm="rsync -a --delete ~liam/Documents/ liam@vm.liammonahan.com:~liam/Documents/"
alias vm='ssh vm.liammonahan.com'
alias prunemergedbranches='git checkout master && git pull && git branch --merged | egrep -v "(^\*|master)" | xargs git branch -d; git fetch --prune'

# I use this for when I want to see the status of all my git projects kept
# together in a single directory without cd-ing into each one..
alias list_git_statuses='for dir in *; do [[ ! -d "$dir/.git" ]] && continue; echo && echo =======$dir======= && git --git-dir=$dir/.git --work-tree=$dir status && echo =============================================; done ;'

# color ls output
if [ $PLATFORM == 'Darwin' ]; then
    alias ls='ls -G'
else
    alias ls='ls --color'
fi

# todo.txt aliases
export TODOTXT_DEFAULT_ACTION=ls
alias todo='~/usr/bin/todo.sh -d ~/usr/etc/todo/todo.cfg'
alias t='todo'
test -f ~/usr/completion.d/todo_completion && source ~/usr/completion.d/todo_completion
complete -F _todo todo
complete -F _todo t

alias ff='find . -type f -name'
alias fd='find . -type d -name'

# docker
dattach() {
    docker-compose exec web scl enable rh-python36 bash
}
dbuild() {
    docker-compose build
}
dup() {
    docker-compose up
}
ddown() {
    docker-compose down
}

# functions

# nota bene
# Arguments:
#   $1 - class
#   $2 - date (optional)
nb () {
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

define () { 
  curl -s dict://dict.org/d:$1 | egrep --color=auto -v "^(220|250|150|151|221)"
}

cls () {
  cd $(echo $*) && ls
}

# quick and dirty linking service
linkme () {
  FILE=$1
  [ -z "$FILE" ] && echo please specify a file && exit 1
  if [ $PLATFORM == 'Darwin' ]; then
    MD5=`md5 -q $FILE`
  else
    MD5=`md5sum $FILE | awk '{print $1}'`
  fi
  scp $FILE root@link.monahan.io:/var/www/html/l/$MD5 > /dev/null
  LINK_URL=http://link.monahan.io/l/$MD5
  if [ $PLATFORM == 'Darwin' ]; then
    echo $LINK_URL | pbcopy
    echo "    ~~~~ Link copied to clipboard ~~~    "
  fi
  echo $LINK_URL
}

# sed find and replace
# shamelessly taken from https://github.com/zackmdavis/dotfiles/
replace () {
    if [[ -z "$1" ]] || [[ -z "$2" ]]; then
        echo "for non-disastrous results, this function needs two arguments"
        return 2
    fi
    find . -type f -not -path "./.git/*" -print0 | xargs -0 sed -i -e "s%$1%$2%g"
}

sendtogood () {
    ssh vm.monahan.io 'echo -e "\n---\n\n'$1'" >> /home/liam/Documents/_good.txt'
}

