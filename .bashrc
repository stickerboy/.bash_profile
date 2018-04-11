#################################################################################
# ~/.bashrc -- modified
# 
# Last Updated: 9:52 AM 4/11/2018
#
################################################################################


# EXPORTS
################################################################################

export PS1="\n[\[\033[1;37m\@ :: \w\[\033[0m]\n[digital@wizzard] $ "

# SSH stuff
################################################################################

SSH_ENV="$HOME/.ssh/environment"

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo succeeded
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    ssh-add ~/.ssh/*_rsa
}

# test for identities
function test_identities {
    # test whether standard identities have been added to the agent already
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $? -eq 0 ]; then
    	ssh-add ~/.ssh/*_rsa
        # $SSH_AUTH_SOCK broken so we start a new proper agent
        if [ $? -eq 2 ];then
            start_agent
        fi
    fi
}

# check for running ssh-agent with proper $SSH_AGENT_PID
if [ -n "$SSH_AGENT_PID" ]; then
    ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
    test_identities
    fi
# if $SSH_AGENT_PID is not properly set, we might be able to load one from
# $SSH_ENV
else
    if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV" > /dev/null
    fi
    ps -ef | grep "$SSH_AGENT_PID" | grep -v grep | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
        test_identities
    else
        start_agent
    fi
fi

#[[ -s $USERPROFILE/.pik/.pikrc ]] && source $USERPROFILE/.pik/.pikrc

function sshcopy {
        cat ~/.ssh/$1.pub | clip
        echo "SSH Key copied to clipboard"
}

# FUNCTIONS
################################################################################

function pbcopy {
	echo $1| clip
	echo "Copied to clipboard"
}

function addpath {
	setx path "%path%;$1"
}

lsmod() {
    ls -al | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/) \
    *2^(8-i));if(k)printf("%0o ",k);print}'
}

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

sendfile() {
    #$1 is a filename, $2 is remote path
    scp $1 SERVER:/WEBROOT/$2/$1
}

# ALIAS COMMANDS
################################################################################

alias bashme="vim ~/.bashrc"
alias bashed="source ~/.bashrc"
alias rc="cat ~/.bashrc"
alias rebash="cp ~/bash_settings/.bashrc ~/.bashrc; bashed; echo rebashed"
alias bsh="echo -ne 'Current Bash Profile saved to Desktop'; rc > $HOME/Desktop/BSHProfile.md"

alias md5="md5sum"
alias ping="ping -n 10"
alias flush="ipconfig //flushdns"
alias dns="ipconfig //displaydns"

alias hosts="vim /c/windows/system32/drivers/etc/hosts"
alias hostsc="cat /c/windows/system32/drivers/etc/hosts > /c/hosts".
alias vps="echo -ne '\e]0;irssi\a'; ssh $1;"
alias work="cd /c/Work/React/"

alias e="explorer ."
alias v="vim"
alias ..="cd .."
alias la="lsmod"
alias stats="stat -c %a"
alias cls="clear"
alias dump="rm -rf $1"
cs() { cd "$1" && ls; }
ca() { cd "$1" && la; }

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
alias ftpush="git ftp push"
alias ftpull="git ftp pull"
alias ftpinit="git ftp init"
alias ftpdown="git ftp bootstrap"
alias ftphelp="git ftp help --man"
alias ftplog="git ftp log"
alias ftpshow="git ftp show"

# NPM / React
alias crap="create-react-app"
alias npmi="npm install"
alias npmg="npm install -g"
alias npmd="npm install --savedev"
alias npmr="npm run"
alias npms="npm start"
alias npmu="npm uninstall"
function build() { 
	echo "Starting build...";
	npm run build;
	echo "Starting server...";
	sleep 3 && "/c/Program Files (x86)/Mozilla Firefox/firefox.exe" -new-tab "http://localhost:9000/";
	pushstate-server build; 
}
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

# .NET
alias dot="dotnet watch run"
