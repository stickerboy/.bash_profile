#################################################################################
# ~/.bashrc -- modified
# 
# Last Updated: Probably today
#
################################################################################


# EXPORTS
################################################################################

export PS1="\n[\[\033[1;37m\@ :: \w\[\033[0m]\n[digital@wizzard] $ "

foo() { cd /c/wamp/ ; }
foo

# SSH stuff
################################################################################
SSH_ENV=$HOME/.ssh/environment

function start_agent {
     echo "Initialising new SSH agent..."
          /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
	       echo succeeded
	            chmod 600 "${SSH_ENV}"
		         . "${SSH_ENV}" > /dev/null
			      /usr/bin/ssh-add;
			      }

			      # Source SSH settings, if applicable

			      if [ -f "${SSH_ENV}" ]; then
			           . "${SSH_ENV}" > /dev/null
				        #ps ${SSH_AGENT_PID} doesn't work under cywgin
					     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
					              start_agent;
						           }
							   else
							        start_agent;
								fi

# Functions
################################################################################

function serv {
	firefox -new-tab http://$1:${2:-80}
}

function pbcopy {
	echo $1| clip
	echo "Copied to clipboard"
}

function addpath {
	setx path "%path%;$1"
}

# Alias commands
################################################################################
alias bashme="vim ~/.bashrc"
alias bashed="source ~/.bashrc"
alias rc="cat ~/.bashrc"

alias md5="md5sum"
alias ping="ping -n 10"
alias cpass="echo bXlzcWwgcGFzcyA3Nzc==| clip"
alias flush="ipconfig //flushdns"
alias dns="ipconfig //displaydns"

alias hosts="vim /c/windows/system32/drivers/etc/hosts"
alias hostsc="cat /c/windows/system32/drivers/etc/hosts > /c/wamp/hosts"
alias pathc="echo $PATH > /c/wamp/path"
alias www="cd /c/wamp/www/"
alias vhosts="vim /c/wamp/bin/apache/apache2.4.9/conf/extra/httpd-vhosts.conf"
alias conf="vim /c/wamp/bin/apache/apache2.4.9/conf/httpd.conf"
alias sqls="mysqladmin -u root shutdown"

alias ..="cd .."
alias la="ls -a"
alias stats="stat -c %a"

# Alias some git commands
alias status="git status"
alias check="git checkout"
alias checkout="git checkout"
alias pull="git pull"
alias branch="git branch"
alias tag="git tag"
alias fetch="git fetch"
alias clone="git clone"
alias commit="git commit"
alias push="git push"
function cherry() { git cherry-pick $1; }
function cherrypick() { git cherry-pick $1; }
alias undo="git reset --soft ^HEAD"

# Git FTP
alias ftpush="git ftp push"
alias ftpull="git ftp pull"
alias ftpinit="git ftp init"
alias ftpdown="git ftp bootstrap"
alias ftphelp="git ftp help --man"
alias ftplog="git ftp log"
alias ftpshow="git ftp show"
