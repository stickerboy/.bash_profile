#################################################################################
# ~/.bashrc -- modified
#
# Last Updated: Probably today
#
################################################################################


# EXPORTS
################################################################################

export PS1="\n[\[\033[1;34m\@ :: \w\[\033[0m]\n[\[\e[1;38m\]digital@wizzard\[\e[m\]] $ "

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# FUNCTIONS
################################################################################

lsmod() {
    ls -al | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/) \
    *2^(8-i));if(k)printf("%0o ",k);print}'
}

get_logs() {
    cat /Applications/mamp/apache2/logs/$1
}
alias logs='get_logs'

gitstats() {
    git log --stat --author $(git config --get user.email) --since="last year" --until="last month" | awk -F',' '/files? changed/ {
        files += $1
        insertions += $2
        deletions += $3
        print
    }
    END {
        print "Files Changed: " files
        print "Insertions: " insertions
        print "Deletions: " deletions
        print "Lines changed: " insertions + deletions
    }'
}

# ALIAS COMMANDS
################################################################################

alias v='sudo vim'
alias bashme='sudo vim ~/.bash_profile'
alias bashed='source ~/.bash_profile'
alias rc='cat ~/.bash_profile'

alias flush='sudo discoveryutil mdnsflushcache;sudo discoveryutil udnsflushcaches;echo DNS flushed' #for yosemite
alias flush2='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;echo DNS flushed' #for 10.9 and and below

alias start='sudo /Applications/mamp/ctlscript.sh start'
alias restart='sudo /Applications/mamp/ctlscript.sh restart'
alias stop='sudo /Applications/mamp/ctlscript.sh stop'

alias hosts='sudo vim /private/etc/hosts'
alias vhosts='sudo vim /Applications/mamp/apache2/conf/extra/httpd-vhosts.conf'
alias conf='sudo vim /Applications/mamp/apache2/conf/httpd.conf'
alias www='cd /Applications/mamp/apache2/htdocs/'

alias ..='cd ..'
alias la='lsmod'
alias dump="rm -rf $1"
cs() { cd "$1" && ls; }
ca() { cd "$1" && la; }

alias bot='ruby ~/irc-scripts/bot.rb'

# Alias some git commands
alias init="git init"
alias add="git add"
alias status="git status"
alias check="git checkout"
alias checkout="git checkout"
alias pull="git pull"
alias branch="git branch"
alias br="git checkout -b $1"
alias tag="git tag"
alias tags="git push --tag"
alias merge="git merge"
alias fetch="git fetch"
alias clone="git clone"
alias commit="git commit -m"
alias amend="git commit --amend -m"
alias push="git push"
alias origin="git push -u origin --all"
alias whatbranch="git symbolic-ref --short HEAD";
alias whatbr="git symbolic-ref --short HEAD";
function upstream() { git push --set-upstream origin $(git symbolic-ref --short HEAD); }
function cherry() { git cherry-pick $1; }
function cherrypick() { git cherry-pick $1; }
function undo() { git reset --soft HEAD^; echo "Previous commit has been reset"; }
function reset() { git reset --hard origin/$(git symbolic-ref --short HEAD); echo "Branch has been reset to origin/$(git symbolic-ref --short HEAD)"; }
alias subi="git submodule init"
alias subm="git submodule update"
alias subr="git submodule update --recursive"
alias ignore="v .gitignore"
alias log="git log -n ${1:-5} --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias pop="git stash apply"
alias stash="git stash"
alias stashes="git stash list"
alias base="git rebase -i"

# Git FTP
alias ftpush='git ftp push'
alias ftpull='git ftp pull'
alias ftpinit='git ftp init'
alias ftpdown='git ftp bootstrap'
alias ftphelp='git ftp help --man'
alias ftplog='git ftp log'
alias ftpshow='git ftp show'

# NPM / React
alias crap="create-react-app"
alias npmi="npm install"
alias npmg="npm install -g"
alias npmd="npm install --savedev"
alias npmr="npm run"
alias npms="npm start"
alias npmu="npm uninstall"
alias vendor="webpack --config webpack.config.vendor.js"
alias cfg="webpack --config webpack.config.js"
alias watch="webpack --watch"

# GitBook
alias book="gitbook";
function booksrv() {
	gulp serve;
}

# Storybook
alias storybook="npm run storybook"
