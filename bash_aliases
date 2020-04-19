# .bash_aliases
# Created by: Liam Monahan

PLATFORM=`uname -s`

# meta
alias ealias='vim ~/.bash_aliases && . ~/.bash_aliases'

# general aliases
alias ll='ls -l'
alias ..='cd ..'
alias grep='grep --exclude-dir .git --exclude-dir env'
alias d3proj="$HOME/usr/bin/d3_project_skeleton.sh"
alias synctovm="rsync -a --delete ~liam/Documents/ liam@vm.liammonahan.com:~liam/Documents/"
alias vm='ssh vm.liammonahan.com'
alias prunemergedbranches='git checkout master && git pull && git branch --merged | egrep -v "(^\*|master)" | xargs git branch -d 2> /dev/null; git fetch --prune'
alias envsource='source env/bin/activate'
alias install-lang='pip install autopep8 flake8 python-language-server pylint-django'
alias mkenv='python3.6 -m venv env && source env/bin/activate && pip install -U pip && install-lang'
alias obliquestrat='shuf -n 1 $HOME/usr/etc/obliquestrat/terms.txt'

# displayplacer configurations
alias displayplacer-laptop-on-desk='displayplacer "id:D84861AC-E10D-1B4C-9B1B-4FA29E931254 res:1920x1080 hz:60 color_depth:8 scaling:on origin:(0,0) degree:0" "id:0E70963A-6DB6-54DF-D518-1C663ABC3100 res:1680x1050 color_depth:4 scaling:on origin:(129,1080) degree:0" "id:E065CF81-C252-F86C-B30F-C2FE82485B7C res:1080x1920 hz:60 color_depth:8 scaling:on origin:(1920,-374) degree:90"'
alias displayplacer-laptop-on-stand='displayplacer "id:D84861AC-E10D-1B4C-9B1B-4FA29E931254 res:1920x1080 hz:60 color_depth:8 scaling:on origin:(0,0) degree:0" "id:0E70963A-6DB6-54DF-D518-1C663ABC3100 res:1680x1050 color_depth:4 scaling:on origin:(-1680,0) degree:0" "id:E065CF81-C252-F86C-B30F-C2FE82485B7C res:1080x1920 hz:60 color_depth:8 scaling:on origin:(1920,-374) degree:90"'

# I use this for when I want to see the status of all my git projects kept
# together in a single directory without cd-ing into each one..
alias list_git_statuses='for dir in *; do [[ ! -d "$dir/.git" ]] && continue; echo && echo =======$dir======= && git --git-dir=$dir/.git --work-tree=$dir status && echo =============================================; done ;'

# color ls output
if [ $PLATFORM == 'Darwin' ]; then
    alias ls='ls -G'
    # open a new iTerm tab in the cwd
    alias newtab='open . -a iterm'
    alias +='newtab'
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
    docker-compose exec web bash
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
  curl -s dict://dict.org/d:$1 | egrep --color=auto -v "^(220|250|150|151|221)" | less
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

