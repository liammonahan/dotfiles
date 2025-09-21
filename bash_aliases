# .bash_aliases
# Created by: Liam Monahan

PLATFORM=`uname -s`

# meta
alias ealias='vim ~/.bash_aliases && . ~/.bash_aliases'

# general aliases
alias ll='ls -l'
alias ..='cd ..'
alias grep='grep --exclude-dir .git --exclude-dir env'
alias gg='git grep'
alias synctovm="rsync -a --stats --exclude env --exclude '*.pyc' --delete ~liam/Documents/ liam@vm.liammonahan.com:~liam/Documents/"
alias vm='ssh vm.liammonahan.com'
alias prunemergedbranches='git checkout master && git pull && git branch --merged | egrep -v "(^\*|master)" | xargs git branch -d 2> /dev/null; git fetch --prune'
alias obliquestrat='shuf -n 1 $HOME/usr/etc/obliquestrat/terms.txt'
alias til='cd ~/code/til && git status && echo && ls'

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

remote-diff() {
    FILE="$1"
    HOST1="$2"
    HOST2="$3"

    diff <(ssh $HOST1 -l root cat $FILE) <(ssh $HOST2 -l root cat $FILE)
}

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

grepp () {
  grep "$1" * -rI
}

define () { 
  curl -s dict://dict.org/d:$1 | egrep --color=auto -v "^(220|250|150|151|221)" | less
}

# quick and dirty linking service
linkme () {
  FILE="$1"
  [ -z "$FILE" ] && echo please specify a file && exit 1
  if [ $PLATFORM == 'Darwin' ]; then
    MD5=`md5 -q "$FILE"`
  else
    MD5=`md5sum "$FILE" | awk '{print $1}'`
  fi
  scp "$FILE" root@link.monahan.io:/var/www/html/l/$MD5 > /dev/null
  LINK_URL=https://link.monahan.io/l/$MD5
  ssh root@link.monahan.io "echo $LINK_URL " — " `basename "$FILE"` >> /var/www/links.txt"
  if [ $PLATFORM == 'Darwin' ]; then
    echo $LINK_URL | pbcopy
    echo "    ~~~~ Link copied to clipboard ~~~    "
  fi
  echo $LINK_URL
}

# find the most recent links
recentlinks () {
    ssh root@link.monahan.io "tail -5 /var/www/links.txt"
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

