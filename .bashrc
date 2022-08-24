#################################################################################
# ~/.bashrc -- modified
# 
# Last Updated: Probably today
#
################################################################################


# EXPORTS
################################################################################

#export PS1='\n[\@ :: \w]\n[digital@wizzard] $ '
export PS1="\n[\@ :: \[\e[32m\]\w] \n[digital@wizzard] \[\e[91m\]\$(parse_git_branch)\[\e[00m\] $ "

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/';
}

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
$SSH_ENV
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

function sshcopy {
        cat ~/.ssh/$1.pub | clip
        echo "SSH Key copied to clipboard"
}

# FUNCTIONS
################################################################################

function conf {
	read -p "Have you built before pushing this code? (y/n) " RESP 
	if [ "$RESP" = "y" ]; then   
		git push;
	else
		return 1;
	fi
}

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
alias bsh="echo -ne 'Current Bash Profile saved to Desktop'; rc > $HOME/Desktop/BSHProfile.md"

alias md5="md5sum"
alias ping="ping -n 10"
alias flush="ipconfig //flushdns"
alias dns="ipconfig //displaydns"

alias hosts="vim /c/windows/system32/drivers/etc/hosts"
alias hostsc="cat /c/windows/system32/drivers/etc/hosts > /c/hosts".
alias send="scp $1 USER@SEVER:~"

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
function clonecd() { echo "Cloning reposirtory and entering directory..."; git clone $1 && cd $(basename $1 .git); }
function cloneinstall() { echo "Cloning repository and running installation..."; git clone $1 && cd $(basename $1 .git) && npmi; }
alias commit="git commit -m"
alias amend="git commit --amend -m"
alias push="conf"
alias pish="conf"
alias origin="git push -u origin --all"
alias whatbranch="git symbolic-ref --short HEAD";
alias whatbr="git symbolic-ref --short HEAD";
alias checkm="git checkout master"
alias mergem="git merge master"
alias checkd="git checkout develop"
alias merged="git merge develop"
function upstream() { git push --set-upstream origin $(git symbolic-ref --short HEAD); }
function clonecd() { git clone $1 && cd $(basename $1 .git); }
function cherry() { git cherry-pick $1; }
function cherrypick() { git cherry-pick $1; }
function undo() { git reset --soft HEAD^; echo "Previous commit has been reset"; }
function reset() { git reset --hard origin/$(git symbolic-ref --short HEAD); echo "Branch has been reset to origin/$(git symbolic-ref --short HEAD)"; }
function clean() { git reset --hard origin/$(git symbolic-ref --short HEAD); git clean -fxd; echo "Branch has been cleaned and reset to origin/$(git symbolic-ref --short HEAD)"; }
alias subi="git submodule init"
alias subm="git submodule update"
alias subr="git submodule update --recursive --remote"
alias ignore="v .gitignore"
alias log="git log -n ${var:=5} --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias pop="git stash apply"
alias stash="git stash"
alias stashes="git stash list --date=local"
alias apply="git stash apply"
alias base="git rebase -i"
function whosyerda() { git reflog --date=local $($1:git symbolid-ref --short HEAD); }
alias bhis="git reflog --date=local $1"
alias lc="git log -1 --pretty=%B"
alias gab="git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias hide="git update-index --assume-unchanged $1"
alias show="git update-index --no-assume-unchanged $1"

# NPM / React
alias ni="npm install"
alias ng="npm install -g"
alias nd="npm install --save"
alias nsd="npm install --savedev"
alias nr="npm run"
alias nrd="npm run dev"
alias na="npm run add-module"
alias nb="npm run build"
alias nm="npm run build-min"
alias ns="npm start"
alias nu="npm uninstall"
alias gcu="npm run serve"

alias vendor="webpack --config webpack.config.vendor.js"
alias cfg="webpack --config webpack.config.js"
alias watch="webpack --watch"

function web() {
	ngrok http 8080 -host-header="localhost:8080";
}
